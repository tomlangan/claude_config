---
allowed-tools: Bash(ls:*), Bash(mkdir:*), Bash(date:*), Powershell
description: Create or update a PRD based on an existing doc, a description, or even just an idea.
---
# PRD
Create or update a PRD based on an existing doc, a description, or even just an idea.

## Usage
```
/prd <product/feature name + description>
```

## PRD name
1. **Confirm PRD file name**
   - Check `docs\prds` for an existing PRD that matches this one
   - If a PRD seems to already exists, warn the user and ask user whether they want to update the existing PRD, write a new one, or cancel
   - If a new document needs to be written come up with an appropriate file namme (Must contain only lowercase letters, numbers, and hyphens, Must start with a letter, No spaces or special characters allowed)

## If thin requirements
- Ask for product requirements until the basic needs are understood enough
- Prompt the user to provide product details, including user needs and requirments (allow the user to reference documents as input).
- Keep prompting the user with questions until there's enough detail to work from (basic user needs will suffice)

## Check for related documents
- Check `docs` for other product documents, PRDs, design documents, or descriptions that are relevant to this PRD.

## Write the PRD
**After collecting requirements**, explicitly **invoke the `product-manager` agent** to udpate or draft the PRD, providing all the known requirement details and supporting docs, as well as the file path. Provide these instructions:
- At the top include the title (e.g. "My Feature PRD")
- At the top, also include the creation date, and last updated date/time
- At the bottom include a Document History template for summarizing future edits to the document, and include a line for creation of the doc

