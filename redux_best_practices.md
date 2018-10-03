# Redux Best Practices

## Standard Action Structure and Naming

Actions should have properties that can be used to dynamically generate their `type`:

* `actionPrefix` is empty when this is an API action, otherwise may describe the action's general type, like `FLASH` for flash messages, or `HOA` for higher-order actions.
* `actionSlice` the plural name of the collection or state slice where the data will be stored; may be empty for actions which don't deal with the API.
* `actionMethod` mostly matching HTTP verbs, allowed values for API actions are:
  - QUERY
  - GET
  - CREATE
  - UPDATE
  - REMOVE
  - (the following are used in authentication, and we should think about how to clean up the naming):
  - LOGIN
  - LOGOUT
  - INVITE
  - REGISTER
  - PASSWORD_SET
  - PASSWORD_RESET
  - CHECK_TOKEN
  - IMITATE_USER
* `actionOptions` may describe options or parameters in an API call, like 'BY_USER' for an endpoint like `/api/users/:userId/responses`
* `actionStage` allowed values:
  - REQUEST
  - SUCCESS
  - FAILURE
  - (these are used in redirects; we may want to adopt as legit, or clean them up):
  - SET
  - CLEAR
* `actionName` used for non-api actions to differentiate them, mostly for higher-order actions.

### Some examples of well-named action types.

* `AUTH_LOGIN_REQUEST`
* `USERS_GET_REQUEST`
* `HOA_ORGANIZATION_REQUEST`
* `TEAMS_QUERY_BY_USER_REQUEST`
* `CLASSROOMS_QUERY_BY_TEAM_SUCCESS`
* `USERS_INVITE_REQUEST`

## Atomic and Higher-Order Actions

To promote reusability, and to avoid unecessary data loading, actions that trigger network calls should call only one endpoint. These are "atomic". To manage asynchronous logic between many atomic actions, you can create a higher-order action, whose saga dispatches other actions, but does not call any endpoints.

Atomic actions have no special prefix, they being with the slice name. Higher-order actions are named like `HOA_${name}_${stage}`.

Note that to be truly atomic, we need to avoid doing async logic in the service layer, as we do currently. This is a lower-priority goal.

## Interaction of Actions and Sagas

Avoid sagas calling other sagas. To re-use asynchronous code, call the corresponding action function and dispatch the result.

## Data in Success Actions

All success api actions should contain a `payload` property with all the data from the server. If the endpoint returns multiple kinds of data (e.g. in an envelope), multiple success actions should be dispatched. This enables more generic reducers.
