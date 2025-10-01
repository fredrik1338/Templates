# TARA meeting template

## 🛡️ Risk Assessment Meeting Template

This is a yearly meeting for ensuring our risk assessment is up to date and that we take any necessary actions due to changing landscapes, new developments or new requirements.
The intention is to tackle all risk related needs with one meeting driven by an appointed role in the team (such as tech lead or PO).
The meeting should coincide with the planning and innovation weeks as we wrap up work done in the previous quarter and may need to plan new work items that come as a result of this meeting.

The driver of the meeting (PO, EM or other chosen role) should prepare the meeting beforehand. This may include bringing information about:

- New legal requirements
- A summary of new features added
- A summary of risk mitigations taken since last meeting
- A proposed scope based on current risk and compliance - related needs
- Organizational changes affecting risks and compliance

At the end of this meeting the goal is to have a clear TODO-list of items to tackle in a prioritized manner.

🕐 Duration
90 minutes (adjust as needed)

## 👥 Participants

- Risk Owner(s)
- Product Manager(s)
- Engineering Lead
- Security Advisor (if possible)
- Legal/Compliance Representative (if possible and necessary)


## Opening and Objectives (5–10 mins)

Due to time constraints we have to choose our scope well. Do not try to do a risk assessment for several applications while also analyzing new sets of compliance requirements. If you need to do several things select them at the start and do them in order.

E.g. For application 1 review all existing risks with regards to the last years new features. Then review the same application with regards to the new laws. E.g. UNR-155, DORA, AI act.

Recap meeting purpose and scope
Set the objectives for this session. If the driver has a prepared scope it should now be presented and decided on
Share updates on regulatory or organizational context (e.g., GDPR, EU AI Act, DORA)

## Review of Existing Risk Register (10 mins)
This step is meant to remind the attendees which risks we have and what the priorities are. Everyone should have at least an idea of what has already been identified and what mitigations has been taken for each risk.

Note: This step is NOT for reading through every risk in detail unless we have specific needs to do so!

Revisit all previously identified risks:
Risk score trends (Likelihood × Impact)
Status of mitigation efforts
Owner accountability
Effectiveness of existing controls
Flag items for escalation or de-prioritization

## System and Application Changes (20 mins)

The focus of this step is to consider what impact our own advancements may have had on our risks.

Present major changes since last review:

- New features, AI model updates, integrations
- Changes to data sources or processing logic
- Any audits, threat intel updates, or known incidents
  
Assess how changes might impact the current risk posture

## Emerging Risks and Re-assessment (30 mins)

Based on the current risk posture, new features and updated requirements do we see any changes in our current risks?
New risks? Changes to old ones?

**Note:** This is where we tie together the input from steps 2 and 3 and assess what work may need to be done.

Open roundtable for new or changed risks:

- Legal/compliance risks (e.g., AI decision transparency)
- Technical risks (e.g., model drift, hallucinations)
- Business/financial impact
- Ethics/bias (e.g., unintended discrimination)

Score new/emerging risks using agreed risk scoring model (e.g., 5x5 matrix or NIST)

## Control Plan and Ownership (20 mins)

For each high/medium risk:

- Define mitigation or monitoring action
- Set due dates
- Tag for follow-up in next assessment or earlier if needed

For each new risk:

- Add to the risk register
- Create a risk document in our pre-agreed risk document storage

In this step we create bullets points for all the work do be done. The work itself will be assigned at a later step and done outside of the meeting. Whether the work consists of writing a story in a backlog, updating a risk registry does not matter as long as the work is noted down and assigned in this meeting.

## Next Steps and Scheduling (5 mins)

Confirm:

- Key takeaways
- Owner assignments
- Due dates
- Schedule next yearly review
- Reassess cadence or scope based on current risk trend
- Assign each piece of work noted down in steps 5 to a person.

## ✅ Optional Meeting Attachments

- Filtered Risk Register for this scope
- Legal/Compliance change summary
- Updated system architecture
- Red team or security test findings