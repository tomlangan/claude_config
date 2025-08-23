---
argument-hint: "[description] | [path-to-markdown-file]"
description: Transform an initial idea into a comprehensive MVP feature specification using specialized design agents
allowed-tools: "*"
---

# Feature Design Command

Transform an initial idea, specification, or description into a comprehensive MVP feature specification using Claude Code's specialized design agents.

The command accepts either:
- A text description of the feature idea: `$ARGUMENTS`
- A path to a markdown file containing the feature specification: `$ARGUMENTS`

## Process Flow

### Phase 1: Feature Architecture Analysis
Uses the `feature-architect` agent to:
- Analyze the initial idea/description
- Identify core functionality requirements
- Map to existing codebase patterns
- Propose technical approach and implementation strategy
- Define MVP scope vs future iterations

### Phase 2: UX Design Optimization  
Uses the `ux-design-optimizer` agent to:
- Evaluate user experience implications
- Balance ideal UX with engineering complexity
- Propose simplified alternatives that deliver core value
- Define user interaction patterns
- Identify potential usability issues

### Phase 3: Feature Coordination
Uses the `feature-coordinator` agent to:
- Coordinate between technical and UX considerations
- Break down into development phases
- Ensure implementation path remains flexible
- Plan iterative development approach
- Define acceptance criteria

### Phase 4: Specification Generation
Produces a comprehensive feature specification including:
- Executive summary
- User requirements and acceptance criteria
- Technical architecture decisions
- MVP implementation plan
- Future iteration roadmap
- Risk assessment and mitigation strategies

## Input Formats

### Text Description
```
Add real-time collaboration with live cursors and conflict resolution
```

### Markdown File
```markdown
# Feature Idea: Advanced Report Filtering

## Problem
Users need more granular control over report generation with complex filtering options.

## Goals
- Reduce cognitive load when selecting report parameters
- Enable power users to create custom filter combinations
- Maintain simplicity for basic use cases

## Context
Current system has basic team/game range selection but lacks advanced filtering.
```

## Output Structure

The command generates `docs/features/[feature-name]-spec.md` with:

```markdown
# [Feature Name] - MVP Specification

## Executive Summary
[Brief overview of feature value and scope]

## User Requirements
### Primary Use Cases
- [Core user scenarios]
### Acceptance Criteria
- [Testable requirements]

## Technical Architecture
### Implementation Approach
- [High-level technical strategy]
### Integration Points
- [How it fits with existing codebase]

## MVP Implementation Plan
### Phase 1: Core Functionality
- [Essential features for initial release]
### Development Tasks
- [High-level implementation steps]

## Future Iterations
### Phase 2: Enhanced Features
- [Next iteration improvements]
### Phase 3: Advanced Capabilities
- [Long-term feature expansion]

## Risk Assessment
### Technical Risks
- [Implementation challenges and mitigation]
### UX Risks
- [User experience concerns and solutions]

## Success Metrics
- [How to measure feature success]
```

## Interactive Mode

When using `--interactive`, the command will:
1. Present initial analysis from each agent
2. Ask for feedback and refinement
3. Iterate on design based on user input
4. Allow back-and-forth between user and agents
5. Refine specification until approved

## Integration with Development Workflow

After generating the specification:
1. Review and approve the MVP scope
2. Use standard task breakdown tools to create implementation plan
3. Begin development with clear requirements and architecture
4. Reference future iterations during development to ensure extensibility

## Best Practices

### For Initial Ideas
- Be specific about the problem being solved
- Include context about current system limitations
- Mention any technical constraints or requirements
- Specify target users and use cases

### For Iterative Refinement
- Be explicit about what aspects need more detail
- Ask for alternative approaches when unsure
- Challenge assumptions about complexity vs value
- Consider both technical feasibility and user value

### For Specification Quality
- Ensure MVP is truly minimal but valuable
- Verify technical approach aligns with codebase patterns
- Confirm UX design balances simplicity with functionality
- Validate that future iterations are properly planned

## Agent Coordination Strategy

The agents collaborate iteratively by building on each other's outputs:

### Round 1: Independent Analysis
1. **Feature Architect** analyzes the initial idea for technical feasibility and implementation approach
2. **UX Design Optimizer** evaluates the idea for user experience implications and complexity trade-offs
3. **Feature Coordinator** reviews both analyses to identify coordination opportunities

### Round 2: Cross-Pollination
4. **UX Design Optimizer** refines design based on technical constraints from architect
5. **Feature Architect** adjusts technical approach based on UX priorities and simplification opportunities
6. **Feature Coordinator** synthesizes the refined inputs into a cohesive implementation plan

### Round 3: Final Integration
7. All agents review the synthesized plan and provide final recommendations
8. User feedback is incorporated and agents iterate as needed
9. Final specification is generated incorporating all perspectives

This creates comprehensive specifications that are both technically sound and user-friendly while maintaining clear development paths from MVP to advanced features.