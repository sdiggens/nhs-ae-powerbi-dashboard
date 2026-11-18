# NHS England A&E Performance Dashboard (Power BI)

An interactive two-page Power BI dashboard comparing four-hour A&E performance for every NHS trust in England with the national figure, over the 12 months from November 2025 to October 2026.

![England overview](overview.png)

![Trust view](trust_view.png)

## Key findings

- **England:** 60.72% of patients at major (Type 1) A&E departments were seen within four hours over the year, from about 17 million attendances. Around 622,000 patients waited over 12 hours for a bed after a decision to admit them.
- **Seasonality:** performance fell to a low of 57.04% in January 2026 and recovered to 63.89% in March.
- **Norfolk:** the county's three acute trusts varied widely against England over the 12 months: Norfolk and Norwich University Hospitals +8.8 percentage points, James Paget University Hospitals +4.0, and the Queen Elizabeth Hospital King's Lynn −3.6.

## Data

Monthly A&E Attendances and Emergency Admissions files published by NHS England (12 CSV files, November 2025 to October 2026). Only **Type 1** (major emergency department) attendances are used, so trusts are compared on like-for-like departments. Walk-in centres and minor injury units are excluded.

## Method

1. **Power Query:** combined the 12 monthly files with the folder connector; kept only the columns needed; filtered to trusts with Type 1 attendances; removed the national TOTAL row; converted the text period (for example "MSitAE-SEPTEMBER-2026") into a proper date.
2. **DAX measures:**
   - **Four-hour performance** = (attendances − attendances over 4 hours) ÷ attendances, calculated as a ratio of sums so that large trusts are weighted correctly.
   - **England comparison** using `CALCULATE` with `REMOVEFILTERS` on trust and region, so the national line stays fixed whichever trust is selected.
   - **Gap vs England** = trust performance − England performance.
3. **Report:** an England overview (headline figures, monthly trend, region filter, trust league table with conditional formatting) and a trust view (searchable trust selector, trust vs England trend, month-by-month gap).

## Checks

- Found and removed a TOTAL row that was double-counting every figure.
- Reconciled the dashboard against the source: September 2026 England performance of 60.38% matches the figure calculated directly from NHS England's file.
- Traced a mismatched figure to a slicer selection left on, and fixed a measure that showed 100% for months with no data.
- Checked a sharp drop at one trust (Airedale, October 2026: 46.23%) against the original CSV to confirm it was genuine, not a data error.

## Limitations

- Four-hour performance doesn't capture everything about A&E quality or patient experience.
- Some trusts aren't directly comparable. For example, specialist children's hospitals see a different mix of patients, which usually means shorter waits.
- The dashboard shows differences between trusts but not their causes.
- NHS England sometimes revises past months; this uses the versions available in November 2026.

## How to open

Download `nhs_ae_dashboard.pbix` and open it in [Power BI Desktop](https://www.microsoft.com/power-bi/desktop) (free, Windows).

Built while learning Power BI, with guidance from an AI tutor; the build, checks and interpretation are my own.

---
Sam Diggens · Economics and Politics graduate, University of Kent
