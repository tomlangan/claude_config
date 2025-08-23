---
allowed-tools: Bash(ls:*), Bash(mkdir:*), Bash(date:*), Powershell
description: Create or update a PRD based on an existing doc, a description, or even just an idea.
---
# TDD
Create or update a TDD (technical design document) based on an existing PRD or design document.

## Usage
```
/tdd <existing document>
```

## Validate input
1. **Confirm file name of PRD or design document**
   - Ensure that at least document was passed in. If not, return an error saying that a document must be passed as a parameter

2. **Confirm that the input documents are valid**
   - Read the file(s) provided describe user needs and requirements
   - If the files do not seem to be PRDs or do not provide clear user requirements, explain what the shortcomings are as a bulletted list (be specific, citing the doc) and ask the user to kindly fill in the required details.

## TDD file name
1. **Confirm TDD file name**
   - Check `docs\tdds` for an existing TDD that matches this one
   - If a TDD seems to already exists that seems to match this one, warn the user and ask user whether they want to update the existing TDD, write a new one, or cancel
   - If a new document needs to be written come up with an appropriate file namme (Must contain only lowercase letters, numbers, and hyphens, Must start with a letter, No spaces or special characters allowed)

## Check for related documents
- Check `docs` for other product documents, PRDs, design documents, or descriptions that are relevant, as well as other TDDs that may be relevant.

## Write the TDD
Explicitly **invoke the `feature-architect` agent** to udpate or draft the TDD, providing all the known requirement details and supporting docs, as well as the file path. Provide these instructions:
- At the top include the title (e.g. "My Feature TDD")
- At the top, also include the creation date, and last updated date/time
- At the bottom include a Document History template for summarizing future edits to the document, and include a line for creation of the doc