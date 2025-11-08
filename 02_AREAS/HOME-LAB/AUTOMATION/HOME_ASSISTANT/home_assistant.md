# Home Assistant Overview

Home Assistant is an open-source home automation platform that puts local control and privacy first. It can be accessed via a web interface, companion apps for mobile devices, or voice commands.

## Adding More Users to Home Assistant

To add more users to your Home Assistant instance, you need to have administrator rights. Follow these steps:

1.  Navigate to **Settings** > **People**.
2.  Click on **Add person**.
3.  Enter the new user's **Name**.
4.  (Optional) Add an image for the user.
5.  Under **Allow login**, select this option if the user should be able to log in. If not selected, they will have limited functionality (e.g., only for device tracking).
6.  If login is allowed, fill in the user information:
    *   Choose a **username** (must be lowercase and contain no spaces).
    *   Enter and securely store a **password**.
    *   Decide if they should have **Local access only** (restricts access from outside your network).
    *   Define if they should have **Administrator rights**.
7.  Select **Create** to finalize the new user account.

**Important Notes:**

*   The initial user account created during Home Assistant setup is the "owner" account and has special privileges.
*   If you don't see "Users" in your configuration menu, ensure that "Advanced Mode" is enabled for your user in your profile settings.
*   Currently, other user accounts have the same access as the owner account, but future updates are expected to allow for more granular restrictions on non-owner accounts.
*   The practical limit to the number of users depends on your system's resources and the complexity of your Home Assistant setup.