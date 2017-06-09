# Project Management Best Practices



## Epic

A feature set, or a big user story.

In ZenHub, these are issues with a special label.

## User Stories

A user-centered (not developer-centered) story of something they can accomplish in the app.

In ZenHub, these are issues with the `user story` label. They're moved through various pipelines on the Board and assigned points at the appropriate time.

The granularity of a user story is agnostic of implementation details. This relates to how to [estimate points](#Points). It also means that implementation details (i.e. [tasks](#Tasks)) should be recorded in sub-tasks via markdown checklists, possibly broken out into their own issues.

## Tasks

Techy stuff we have to do to make the user stories work. These are vanilla issues (they don't get points), although they may have labels like `bug`.

## Points

Points should be estimated based on _user-facing feature complexity_ rather than time-based concepts like "time to code" or "difficulty" because that allows for the team's velocity to improve over time. In other words, when the team develops a better workflow, switches to a more powerful language, or levels up personal skills, then they should be getting more points done in the same amount of time rather than decreasing their estimates of how many points a given feature will take.

This does mean that early points in a project may take a long time as the team builds infrastructure, but this way the points attributed to each issue are _correct relative to each other_ and are _independent of their time ordering_ on the Board.

Picked up these opinions from [this thread](https://softwareengineering.stackexchange.com/questions/173292/should-you-ever-re-estimate-user-stories/173308#173308).

It also means that velocity is more interpretable from outside the team. A ramp up and then a plateau represents new infrastructure followed by more efficient work. A high initial value represents good re-use of tools and code.

### Estimating Points

* `1` - Dead simple. The user gets a new button.
* `2` - Some complexity. The user gets a button which has some state.
* `3` - Definite complexity. Solution requires an initial design phase and/or additional definition of the problem. Multiple bells and whistles may be present.
* `5` - Ill defined and potentially hairy. Placeholder for being broken into multiple issues.

### (Not) Re-estimating Points

The purpose of knowing your team's velocity is for prospective planning. Increasing an issue's point value retrospective artificially inflates velocity with information we won't have when prospectively estimating points the next time. In other words, point values should incorporate our bias toward underestimation in the planning phase.

Do reflect on how to estimate well, but don't re-estimate.

Picked up these opinions from [this thread](https://softwareengineering.stackexchange.com/questions/173292/should-you-ever-re-estimate-user-stories/173308#173308).

## Sprints

In ZenHub, these are Milestones.

Weekly? Two weeks?

The goal of a **scrum** is to slot issues from the backlog into the current sprint.

The goal of a **retrospective** is to reflect on progress over the week and to refresh the Board:

* What worked or didn't work: workflow, communication, design patterns, etc.
* Check out velocity or other metrics.
* Does the backlog need refreshing?
* Are any epics opening or closing?
* Are any releases coming up?
* Pats on the back, especially if an epic was closed or release finished.
