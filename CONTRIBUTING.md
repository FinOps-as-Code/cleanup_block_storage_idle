# Contributing to FinOps Automation

Thank you for your interest in contributing.

This repository is part of the FinOps Foundation ecosystem and exists to turn FinOps decisions into practical, reusable automation. Our current priority is executable, independent scripts that help teams improve cost efficiency, governance, and operational discipline. We welcome contributions that are useful, well engineered, and grounded in real-world FinOps needs.

We want this repository to remain practical, approachable, and valuable to adopters across different environments. That means contributions should favor clarity over complexity, solve concrete problems, and be safe to evaluate and run.

## Welcome

FinOps is not only about visibility. It is also about execution.

Organizations often know where waste exists or where policy needs improvement, but they still need practical ways to act on that information. This repository focuses on automation that helps bridge that gap. The goal is to provide open, understandable contributions that can help teams take action on cost optimization, efficiency, and governance opportunities.

If you are contributing here, you are helping create tools that others may adapt and use in very different environments. Please write with that responsibility in mind.

## Project Vision

This repository currently prioritizes simple, executable, and independent FinOps scripts.

That focus is intentional. Scripts are often the fastest and most accessible way to solve real FinOps problems, validate ideas, and enable adoption across different teams and levels of maturity. They are easy to inspect, easy to test, and easy to adapt.

At the same time, this repository is not intended to artificially limit future evolution. Over time, the project may expand to include additional supporting assets, patterns, or implementation approaches where they clearly serve the same practical mission. For now, the main contribution model is focused on standalone automation that is direct, useful, and maintainable.

## Contribution Principles

We welcome contributions that align with the following principles:

- Solve a real FinOps problem related to cost reduction, efficiency, governance, or operational visibility.
- Prefer simple and direct implementations over unnecessary abstraction.
- Design contributions to be understandable, reusable, and maintainable by others.
- Keep scripts safe by default whenever possible.
- Use parameters and configuration instead of hardcoded environment-specific values.
- Include clear logging or output so users can understand what the script is doing.
- Avoid assumptions that make contributions difficult to run outside the original author's environment.
- Write code and documentation for an open source audience, not only for an internal team.

All submitted code must be tested. Contributions must also follow sound software engineering standards, coding standards, and generally accepted good practices for readability, maintainability, and safety.

## Support and Responsibility Disclaimer

All code in this repository is provided on an "as is" basis.

Contributors and maintainers do not guarantee support, service levels, operational fitness, or ongoing maintenance for any contribution. Use of any script or other artifact from this repository is at the adopter's own discretion and risk.

Anyone choosing to use content from this repository is responsible for:

- validating behavior in their own environment
- reviewing safety, permissions, and operational impact
- confirming compatibility with their cloud, platform, tooling, and governance requirements
- applying any internal controls, approvals, or change management processes required by their organization

This repository aims to provide useful open source building blocks, not managed services or production guarantees.

## Getting Started

Before contributing, please take time to understand the current shape of the repository and the type of contribution that will be most useful.

A good starting approach is:

1. Review the repository structure and existing scripts.
2. Identify a concrete FinOps problem your contribution will address.
3. Keep the solution focused and easy to evaluate.
4. Make sure the code is tested and documented.
5. Prepare your pull request with a clear explanation of purpose, behavior, and validation steps.

If you are proposing a new script, ask yourself:

- What specific FinOps problem does this solve?
- Is the script safe and understandable for someone outside my environment?
- Can a maintainer quickly review what it does and how to test it?
- Does it avoid hidden dependencies, private assumptions, or sensitive data?

## Types of Contributions

We welcome several kinds of contributions, with scripts as the current primary focus.

### Scripts

Scripts are the main contribution type for this repository today.

A strong script contribution typically:

- addresses a real use case in cost optimization, efficiency, or governance
- can be executed independently
- is focused on one problem or workflow
- uses safe defaults
- supports parameters or configuration
- includes logging or meaningful output
- can be tested and reviewed without excessive setup

Examples may include automation for identifying waste, enforcing guardrails, summarizing opportunities, or supporting operational cleanup with appropriate safety controls.

### Documentation

Clear documentation improves adoption and maintainability.

Documentation contributions may include:

- README improvements
- usage examples
- architecture or design notes for specific scripts
- contribution guidance
- clarification of assumptions, limitations, or safety considerations

Documentation should be concise, accurate, and written for readers who may not share the original author's context.

### Bug Fixes

Bug fixes are always welcome.

Please aim to:

- describe the issue clearly
- explain the expected and actual behavior
- include tests where appropriate
- avoid unrelated refactoring unless it is necessary for the fix

## Contribution Process

The contribution process should remain lightweight, but disciplined.

1. Fork the repository and create a branch for your work.
2. Implement your change with a clear, focused scope.
3. Test the change.
4. Update documentation as needed.
5. Submit a pull request with enough context for maintainers to review efficiently.

Small, well-scoped pull requests are easier to review and more likely to move quickly. If a change is broad or introduces a new pattern, explain the reasoning clearly.

## FinOps Context Expectations

This repository exists to support practical FinOps execution.

Contributions should reflect that context. A useful submission should connect technical behavior to a FinOps outcome. That outcome may relate to one or more of the following:

- reducing unnecessary cost
- improving resource efficiency
- supporting accountability and governance
- making financial decisions more actionable
- enabling safer operational follow-through on identified opportunities

Contributions should not be generic automation without a clear FinOps purpose. The connection to cost, efficiency, governance, or practical financial operations should be explicit.

## Pull Request Guidance

A pull request should help maintainers understand both the code and the FinOps value.

Please include:

- what the contribution does
- what FinOps problem it solves
- why the approach is useful
- how it was tested
- any assumptions, limitations, or safety considerations
- any documentation updates required

Good pull requests are concrete and reviewable. Reviewers should not have to infer the use case, operating model, or expected behavior.

If your contribution is a script, it is especially helpful to include:

- the intended execution context
- required inputs or parameters
- whether the script supports dry-run behavior
- example usage
- expected output or result

## Best Practices for Scripts

Because scripts are the current primary focus, we encourage contributors to follow these practices whenever possible:

- Keep scripts independent and easy to execute.
- Prefer one script solving one clear problem.
- Use configuration, flags, or parameters instead of hardcoded values.
- Default to safe behavior.
- Avoid destructive actions unless explicitly enabled.
- Support dry-run mode where meaningful.
- Include clear logging or output.
- Make error handling understandable and predictable.
- Keep dependencies minimal.
- Write code that is easy for others to read and modify.
- Include tests appropriate to the script's behavior.
- Document prerequisites, inputs, and expected outcomes.

Where relevant, scripts should be designed so they can run in different environments with minimal changes. Please avoid embedding anything environment-specific that would reduce portability or create risk.

Do not include:

- account IDs
- secrets
- tokens
- private endpoints
- internal-only configuration
- organization-specific sensitive details
- any other confidential or environment-specific private information

If sample configuration or examples are needed, use sanitized placeholders.

## Governance

This repository is maintained as an open source project within the FinOps Foundation ecosystem.

Maintainers are responsible for guiding the direction of the repository, reviewing contributions, and preserving quality and consistency. Acceptance of a contribution is based on project fit, clarity, maintainability, safety, and usefulness to the broader audience.

Not every contribution will be merged. Maintainers may request changes, suggest scope reduction, or defer a proposal if it does not align with the current direction of the repository.

The current direction emphasizes practical automation, especially standalone scripts, while remaining open to thoughtful evolution over time.

## Code of Conduct

Contributors are expected to participate respectfully and constructively.

Please approach discussion, review, and collaboration in a professional and open source friendly manner. Assume good intent, welcome feedback, and keep conversations focused on improving the work.

Harassment, hostility, discrimination, and disrespectful behavior have no place in this project.

## Questions and Discussions

If you have questions, need clarification, or want to discuss a contribution before investing heavily in implementation, open an issue or start the appropriate repository discussion if available.

Early discussion is especially helpful when:

- proposing a new type of script
- introducing a new pattern or dependency
- making a broad refactor
- changing repository structure
- contributing something that may affect how future work is organized

Thoughtful discussion helps keep contributions aligned and reduces unnecessary rework.

## Closing Philosophy

This repository exists to make FinOps more executable.

The best contributions are the ones that take an important financial operations problem and turn it into something practical, understandable, and reusable. We value contributions that are grounded in real needs, engineered with care, and written so others can confidently review, adapt, and build on them.

If your contribution helps teams act more safely, efficiently, and effectively on FinOps priorities, it is likely a strong fit.
