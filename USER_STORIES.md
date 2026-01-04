# User Stories - Real Estate Application

## User Story 1: User Registration
**As a** new user  
**I want to** register for an account with my full name, phone number, email, and password  
**So that** I can access the real estate application and save my preferences

### Acceptance Criteria:
- User can input full name, phone number with country code (+62), email, and password
- Form validates all required fields
- User receives error messages for invalid inputs
- Successfully registered users can proceed to login
- Phone number field defaults to Indonesia (+62)

---

## User Story 2: User Login
**As a** registered user  
**I want to** log into my account using my email and password  
**So that** I can access personalized features and saved properties

### Acceptance Criteria:
- User can input email and password
- Invalid credentials show appropriate error messages
- Successful login navigates user to home screen
- Password field is masked for security
- "Sign Up" link is available for new users

---

## User Story 3: Browse Properties
**As a** user  
**I want to** view a list of available properties on the home screen  
**So that** I can explore real estate options

### Acceptance Criteria:
- Home screen displays property listings with images
- Each property shows key information (name, price, location)
- Logo is visible in the app header
- Properties are displayed in a scrollable list/grid
- Loading indicator shows while fetching data

---

## User Story 4: View Property Details
**As a** user  
**I want to** tap on a property to see its detailed information  
**So that** I can make informed decisions about properties I'm interested in

### Acceptance Criteria:
- Navigation icon/button is visible on property cards
- Tapping a property navigates to detail screen
- Detail screen shows comprehensive property information (description, price, location, amenities)
- Images are displayed clearly
- Back button returns to previous screen

---

## User Story 5: Save Favorite Properties
**As a** user  
**I want to** save properties to my favorites list  
**So that** I can easily access properties I'm interested in later

### Acceptance Criteria:
- Favorite/heart icon is visible on property cards
- Tapping favorite icon saves property locally
- Favorites persist after app restart (local storage)
- User can view all saved favorites in a dedicated section
- User can remove properties from favorites

---

## User Story 6: Access External API Data
**As a** user  
**I want to** view additional information from external real estate APIs  
**So that** I can get comprehensive property market data

### Acceptance Criteria:
- App fetches data from an external API
- API data is displayed in a dedicated screen
- Loading state is shown during API calls
- Error handling for failed API requests
- Data refreshes on pull-to-refresh gesture

---

## User Story 7: Access Settings Menu
**As a** user  
**I want to** access a settings menu from the home screen  
**So that** I can customize my app experience and manage my account

### Acceptance Criteria:
- Settings icon is visible in the app header/navigation
- Tapping settings icon opens settings menu
- Menu includes at least 3 options: Profile, Notifications, Privacy
- Logout/Sign Out option is available
- Menu has clear and intuitive design

---

## User Story 8: Configure App Settings
**As a** user  
**I want to** adjust application settings  
**So that** I can personalize my experience and control app behavior

### Acceptance Criteria:
- Settings screen shows configuration options
- User can toggle notification preferences
- User can update profile information
- Changes are saved locally and persist
- Clear feedback is provided when settings are updated

---

## User Story 9: Receive Notifications
**As a** user  
**I want to** receive notifications about new properties and updates  
**So that** I stay informed about real estate opportunities

### Acceptance Criteria:
- User can enable/disable notifications in settings
- Test notification can be triggered from settings
- Notifications appear in device notification tray
- Tapping notification opens the app
- Notification setup is clearly documented in settings
