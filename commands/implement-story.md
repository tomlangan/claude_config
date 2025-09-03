---
allowed-tools: Bash(ls:*), Bash(mkdir:*), Bash(date:*), Powershell
description: Once a sprint plan is in place, use this command to execute it and write the code.
---
# execut-sprint-plan
Once a sprint plan is in place, use this command to execute it and write the code.

## Usage
```
/execute-sprint-plan <folder>
```

## Validate input
1. **Confirm folder name and sprint plan file**
   - The folder specified should be under `docs/` and contain a sprint-plan.md. If the folder slug is not found verbatim, *stop* and ask the user, presenting any viable optoins that seem right from the `docs` folder. 
   - If no `sprint-plan.md` file is found, *stop* and ask the user to run `/plan-sprint <folder-slug>` first.

2. **Confirm that the input documents are valid**
   - Read `sprint-plan.md`. Ensure it contains incomplete stories and/or tasks. If there are no incomplete stories/tasks *Stop* and explain to the user that this sprint plan already looks complete and they might want to run `/plan-sprint <folder-slug>` to generate new tasks.
   - Check for internal references (such as files referenced in docs sub-folders). If any docs are missing, warn the user.

## Execute every story in the sprint plan

Perform the following sequence for the entir epic in this sprint plan.  For each unfinished story in the sprint plan, one at a time, in order, until all the stories have been fully implemented:

1. **Write the code for the story, starting with tests**
    - Implement all tests for a story before implementing any of the work items
    - It's OK to implement tests in parallel
    - Once all tests are written, it's OK to implement tasks in parallel
    - Once a test or task is implemented, mark it with a green check ✅
    - Once all the tests and tasks for the story are implemented move on to the next step

2. **Optimization**
    - If the story included any UX, explicitly call the `ux-design-optimizer` agent with details of the UX and the sprint story, including all the references to the PRD and TDD, and ask the `ux-design-optimizer` to review and optimize the UX that's been implemented

3. **Code validation**
    - Run a build of the code and tests.  Verify that they all build. If they do not build, come up with robust fixes for each build error and warning until the build completes cleanly.
    - Execute all the tests. Verify that all the tests pass. If any tests fail, come up with robust fixes for either the test or the product code (ensuring you fix the right one!) until all tests pass. Do not skip any tests.

4. **Mark story complete and move on to the next**
    - Once the story has been validated, add a check next to it
    - If there are any incomplete stories, go to step 1 and implement the next one


## Update the TDD

When ALL tasks in the sprint have been completed, ensure the story all tasks in sprint-plan.md have been ✅ checked off, then open the TDD and mark the completed storie(s) with green checks ✅ and if any epics were completed, mark the epic complete as well ✅