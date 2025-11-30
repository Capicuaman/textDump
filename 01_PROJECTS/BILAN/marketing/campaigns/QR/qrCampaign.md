Of course. Here is the cleaned-up version of your marketing strategy, organized for clarity and actionability.

***

### **🎯 Bilan Electrolyte: UTM & QR Code Tracking Strategy**

This comprehensive plan outlines how to implement proper tracking for your "Don't Stop" guerrilla marketing campaign.

---

### **1. Campaign Foundation: "Don't Stop" Guerrilla Marketing**

This strategy is built around your core idea: targeting joggers with hydration vests in high-traffic areas using QR codes on sample packages.

---

### **2. UTM Parameter Structure & Naming Convention**

**Core UTM Parameters:**
*   `utm_source`: Traffic origin (e.g., `qr_code`, `instagram`, `email`)
*   `utm_medium`: Marketing medium (e.g., `guerrilla`, `social`, `print`)
*   `utm_campaign`: Campaign name (e.g., `dont_stop_sep2024`)
*   `utm_content`: Specific creative or variation (e.g., `park_3g`)
*   `utm_term`: Keyword (optional, mainly for paid search)

**Recommended Bilan Structure:**
```
utm_source=qr_code
utm_medium=guerrilla
utm_campaign=dont_stop_sep2024
utm_content=[location_type]_[package_size]
```

---

### **3. QR Code Implementation Strategy**

*   **Dynamic QR Codes (Recommended):** Use services like Bitly, QRCode Monkey, or QRCode Generator. These allow you to update the destination URL without changing the printed code and provide real-time scan analytics.
*   **Static QR Codes (For Specific Campaigns):** Generate unique, unchangeable codes for one-time events or specific locations to isolate performance data.

---

### **4. Campaign Deployment Matrix**

| Location Type | UTM Parameters | QR Code Type | Target Metric |
| :--- | :--- | :--- | :--- |
| **Parks/Jogging Trails** | `content=park_3g` | Static | Scans → Website Visits |
| **Yoga Studios** | `content=yoga_studio_200g` | Dynamic | Demo Requests |
| **Gyms/Fitness Centers** | `content=gym_1kg` | Dynamic | Wholesale Inquiries |
| **Events/Retreats** | `content=event_[name]_sample` | Static | Email Signups |

---

### **5. Sample URL Structures**

**For Guerrilla Campaign (3g samples):**
```
https://getbilan.com/hydration?utm_source=qr_code&utm_medium=guerrilla&utm_campaign=dont_stop_sep2024&utm_content=park_3g_sample
```

**For Yoga Retreat Partnership:**
```
https://getbilan.com/retreat-partners?utm_source=qr_code&utm_medium=partnership&utm_campaign=yoga_retreat_aug2024&utm_content=haramara_200g
```

---

### **6. Tracking & Analytics Setup**

**Google Analytics 4 (GA4) Configuration:**
1.  Set up custom dimensions for your UTM parameters.
2.  Create custom reports to monitor QR code performance.
3.  Set up conversion tracking for:
    *   Sample requests
    *   Online purchases
    *   Wholesale inquiries
    *   Email subscriptions

**n8n Automation Opportunities:**
*   Automate the generation of UTM-tracked URLs.
*   Create a workflow that updates your CRM when a QR code is scanned.
*   Set up alerts for high-performing locations.
*   Automate ROI calculation reports.

---

### **7. Implementation Checklist**

**✅ Pre-Campaign:**
- [ ] Set up GA4 with custom dimensions.
- [ ] Finalize and document UTM naming conventions.
- [ ] Design branded QR codes.
- [ ] Test all QR codes for functionality.
- [ ] Build and optimize dedicated landing pages.

**✅ During Campaign:**
- [ ] Monitor analytics daily for real-time insights.
- [ ] Track top-performing locations and tactics.
- [ ] A/B test messaging on stickers and packaging.
- [ ] Document successful guerrilla marketing actions.

**✅ Post-Campaign:**
- [ ] Analyze conversion rates by location and content.
- [ ] Calculate ROI for each campaign type.
- [ | Update future strategy based on data insights.
- [ ] Plan the next phase with an optimized approach.

---

### **8. Critical Thinking Questions**

1.  **Hypothesis Testing:** Which locations do you hypothesize will perform best? How will you structure the test to prove or disprove this?
2.  **Qualitative Impact:** Beyond scan counts, how will you measure brand awareness and customer sentiment?
3.  **Lead Nurturing:** What is the plan for users who scan but do not convert immediately (e.g., retargeting ads, email sequences)?
4.  **Product Optimization:** How can the scan/conversion data inform your product packaging and marketing messaging?
5.  **Secondary Metrics:** What other metrics (e.g., time on site, pages per session) will indicate overall campaign health?

---

### **9. Recommended Next Steps**

1.  **Run a Pilot Program:** Test this strategy in 2-3 locations first.
2.  **Build Analytics First:** Ensure GA4 and tracking are fully configured before any printing or deployment.
3.  **Create a Tracking Sheet:** Build a simple spreadsheet to log all UTM combinations and their performance.
4.  **Use a Shortener:** Consider using a tool like Bitly to create shorter, more scannable URLs and manage them easily.

***

**Let me know if you'd like help setting up specific UTM templates or a tracking spreadsheet structure.**
