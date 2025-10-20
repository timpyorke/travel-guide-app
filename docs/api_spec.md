# Travel Guide API & Service Specification

## 1. Goals & Scope
- Deliver a Backend-for-Frontend (BFF) that mirrors the current Flutter UX while enabling personalization, persistence, and optional authentication.
- Support guest browsing with seamless upgrade to authenticated experiences (saved plans, notification settings, timeline sync).
- Provide clear contracts for replacing mock data across Home, Explore, Plan, Favorites, and Profile modules.
- Maintain low-latency read paths and predictable payloads suitable for mobile clients.

### Primary Use Cases
- Personalize the home feed by user location and interests.
- Browse curated collections and experience details across explore and favorites.
- Persist trip plans, timeline items, and saved content for authenticated users.
- Manage onboarding (location selection, preferences) and notification settings.

### Out of Scope (Phase 1)
- Payments or bookings.
- Real-time collaboration on plans.
- Third-party OAuth providers (email/password or magic link only for MVP).

## 2. Architecture Overview
- **Pattern:** RESTful BFF backed by a modular service layer (Auth, Profile, Content, Plans).
- **Recommended Stack:** TypeScript (NestJS/Fastify) or Kotlin (Ktor), PostgreSQL for persistence, Redis for caching, S3/CloudFront for media assets.
- **Authentication:** JWT access + refresh tokens, HTTP-only secure refresh cookie, short-lived access token returned in response body.
- **Caching:** Redis for hot home-feed slices, search suggestions, and pre-rendered collections; CDN for static media.
- **Background Jobs:** Worker queue (BullMQ / Sidekiq / Quartz) for seasonal content refresh, precomputing personalized feeds, analytics aggregation.
- **Observability:** Structured logging, tracing (OpenTelemetry), metrics (Prometheus/Grafana).

```
Flutter App ─▶ API Gateway ─▶ Travel Guide BFF ─▶ Services (Auth, Profile, Content, Plans)
                                      │
                                      ├─▶ PostgreSQL (primary datastore)
                                      ├─▶ Redis (cache/session, feature flags)
                                      └─▶ Object Storage/CDN (media)
```

## 3. Domain Model
- **User**
  - `id`, `email`, `displayName`, `avatarUrl`, `authProvider`, `createdAt`, `updatedAt`
  - Flags: `onboardingComplete`, `firstLaunchSeen`, `hasNotificationsEnabled`
- **LocationContext**
  - `id`, `countryCode`, `cityCode`, `displayName`, `timezone`, `currency`, `seasonalHighlights[]`
- **PreferenceProfile**
  - `userId`, `interestTags[]`, `budget`, `pace`, `language`, derived segments for personalization.
- **Collection**
  - `id`, `type` (`home-feature`, `explore`, `favorites`), `title`, `subtitle`, `heroMedia`, `sections[]`
- **Experience**
  - `id`, `collectionId`, `title`, `subtitle`, `summary`, `details`, `media`, `cta`
- **TripPlan**
  - `id`, `userId`, `title`, `destination`, `tags[]`, `durationDays`, `isShared`, `timelineEntries[]`
- **TimelineEntry**
  - `id`, `planId`, `dayLabel`, `time`, `title`, `description`, optional `location`, `notes`
- **SavedItem**
  - `id`, `userId`, `resourceType` (`collection|experience|plan`), `resourceId`, `note`, timestamps.

## 4. API Surface

### 4.1 Authentication & Profile
| Verb | Path | Description |
| --- | --- | --- |
| `POST` | `/v1/auth/signup` | Create account, return tokens |
| `POST` | `/v1/auth/login` | Email/password login |
| `POST` | `/v1/auth/refresh` | Issue new access token via refresh cookie |
| `POST` | `/v1/auth/logout` | Invalidate refresh token |
| `GET` | `/v1/profile` | Fetch profile, preferences, notification settings |
| `PATCH` | `/v1/profile` | Update display name, avatar, tagline |
| `PUT` | `/v1/profile/preferences` | Update interests, language, budget, pace |
| `PUT` | `/v1/profile/notifications` | Update notification toggles |

### 4.2 Location & Onboarding
| Verb | Path | Description |
| --- | --- | --- |
| `GET` | `/v1/locations/search?q={term}` | Autocomplete by city/country |
| `GET` | `/v1/locations/{id}` | Detailed location context |
| `POST` | `/v1/profile/location` | Persist selected home base |

### 4.3 Home Feed
`GET /v1/home-feed?locationId=loc_kyoto&include=planAhead,insights`

Response:
```json
{
  "hero": {"title": "Kyoto Spring Escape", "subtitle": "2 days, 6 highlights", "imageUrl": "..."},
  "cityContext": [
    {"label": "Cherry Blossom Outlook", "icon": "local_florist", "deepLink": "/city-insights"},
    {"label": "Transit Tips", "icon": "train", "deepLink": "/city-transit"}
  ],
  "features": [
    {"id": "outdoors", "title": "Epic trails", "subtitle": "Guided hikes", "collectionId": "col_outdoors"}
  ],
  "planAhead": [
    {"planId": "plan_123", "title": "Kyoto Night Lanterns", "startDate": "2024-04-04", "days": 2, "tags": ["Scenic","Foodie"]}
  ],
  "insights": [
    {"id": "ins_991", "title": "Tea Ceremony Workshop", "summary": "Hands-on lesson...", "cta": {"label": "Add to plan", "planTemplateId": "tpl_tea"}}
  ]
}
```

### 4.4 Explore & Collections
| Verb | Path | Description |
| --- | --- | --- |
| `GET` | `/v1/collections?type=explore` | Paginated themed collections |
| `GET` | `/v1/collections/{id}` | Collection details with sections/entries |
| `GET` | `/v1/experiences/{id}` | Detailed spotlight for list tiles |

### 4.5 Plans & Timeline
| Verb | Path | Description |
| --- | --- | --- |
| `GET` | `/v1/plans` | List user plans |
| `POST` | `/v1/plans` | Create plan (title, destination, tags, duration) |
| `GET` | `/v1/plans/{planId}` | Retrieve plan with timeline |
| `PATCH` | `/v1/plans/{planId}` | Update title, tags, metadata |
| `DELETE` | `/v1/plans/{planId}` | Delete plan |
| `POST` | `/v1/plans/{planId}/timeline` | Add timeline entry |
| `PATCH` | `/v1/plans/{planId}/timeline/{entryId}` | Update entry |
| `DELETE` | `/v1/plans/{planId}/timeline/{entryId}` | Remove entry |

Timeline entry payload:
```json
{
  "dayLabel": "Day 1",
  "time": "11:00",
  "title": "Stroll Through Arashiyama",
  "description": "Walk the bamboo grove...",
  "location": "Arashiyama Bamboo Grove",
  "notes": "Reserve tickets ahead"
}
```

### 4.6 Favorites & Activity
| Verb | Path | Description |
| --- | --- | --- |
| `GET` | `/v1/favorites` | Retrieve saved collections/experiences/plans |
| `POST` | `/v1/favorites` | Save resource (`resourceType`, `resourceId`, optional note) |
| `DELETE` | `/v1/favorites/{resourceId}` | Remove favorite |
| `GET` | `/v1/activity/recent` | Recent plan edits, saved items, insights |

## 5. Data Model Illustrations

### Plan Aggregate (PostgreSQL)
```sql
TABLE users (
  id uuid PRIMARY KEY,
  email text UNIQUE NOT NULL,
  display_name text,
  ...,
  created_at timestamptz DEFAULT now()
);

TABLE trip_plans (
  id uuid PRIMARY KEY,
  user_id uuid REFERENCES users(id),
  title text NOT NULL,
  destination text,
  tags text[],
  duration_days int,
  is_shared boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

TABLE timeline_entries (
  id uuid PRIMARY KEY,
  plan_id uuid REFERENCES trip_plans(id) ON DELETE CASCADE,
  day_label text NOT NULL,
  time text,
  title text NOT NULL,
  description text,
  location text,
  notes text,
  position int NOT NULL
);
```

### Home Feed Cache Key
`home_feed:{locationId}:{language}:{segmentHash}` → JSON blob with TTL (15–30 min) and manual busting on preference update.

## 6. Flutter Integration Strategy
- **Networking:** introduce `dio`-based `TravelApiClient` with interceptors for auth headers and retry/backoff. Enable logging per build flavor.
- **Repository Layer:** create repositories (`AuthRepository`, `HomeRepository`, `PlansRepository`, etc.) that transform DTOs into app models consumed by Riverpod providers.
- **State Management:** leverage existing `AsyncNotifier`/`StateNotifier` patterns; wrap API calls with `AsyncValue.guard`.
- **Persistence:** use `flutter_secure_storage` for refresh token or session key, `shared_preferences` for onboarding flags mirrored to server.
- **Error Handling:** map HTTP errors to domain-specific failures (e.g., `PlanNotFound`, `ValidationError`) and surface via snackbars/dialogs already used in Plan/Profile flows.
- **Offline Considerations:** cache last successful home feed and plans in local storage for read-through fallback (Phase 2 enhancement).

## 7. Delivery Roadmap
1. **MVP (Home & Auth)**
   - Stand up auth endpoints and minimal user/profile tables.
   - Implement `/v1/home-feed` with seeded collections and location personalization.
   - Wire Flutter Home Page to live provider; add integration tests.
2. **Plans & Favorites**
   - Ship plans CRUD + timeline endpoints, migrate Plan tab to server data.
   - Implement favorites API, sync UI interactions.
3. **Explore Expansion & Personalization**
   - Add search facets, dynamic collections, seasonal insights job.
   - Introduce analytics events (activation, plan creation).
4. **Hardening & Scaling**
   - Add rate limiting, improve caching strategy, finalize alerting.
   - Evaluate GraphQL overlay or gRPC for future clients if needed.

## 8. Open Questions
- Preferred auth mechanism for MVP (email/password vs. passwordless)?
- Does seasonal content require CMS integration or manual JSON seeds?
- Target SLA/latency to size cache TTL and DB indexes.
- Requirements for localization (server-driven translations vs. client).

---
This specification should unblock implementation of the Travel Guide backend and guide Flutter integration to replace mock data with live, personalized experiences.
