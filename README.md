# FormCraft

FormCraft is a customizable web and mobile form builder application built with Flutter. It allows users to create, edit, and fill out forms with various question types, providing a simplified experience similar to Google Forms.

## Key Features

### 1. Core Features

#### Form Creation:
- **Multiple Question Types:**
  - Short answer (text)
  - Paragraph (long text)
  - Multiple choice (radio buttons)
  - Checkboxes (multiple answers)
  - Dropdown
  - Date picker
- **Reorder Questions:** Easily reorder questions within a form.
- **Required Questions:** Option to mark questions as "Required" to ensure user input.

#### Form Preview & Fill Mode:
- Fill out and submit forms.

#### Form Submission Handling:
- On submission, a success message is displayed.
- Users can view the entered data in a read-only format after submission.

### 2. Platform Support

The app is designed to work and maintain visual consistency on:
- **Android (mobile)**
- **Web (responsive layout)**

## Technical Requirements

- **Flutter SDK:** Developed with the latest stable version of Flutter.
- **Dart Null Safety:** Utilizes Dart's null safety features for robust code.
- **State Management:** Provider is used for state management.
- **Internal Storage:** Form structures are stored internally in a JSON-like format (though currently, they are stored as Dart objects in memory and not persisted to JSON files).

## Bonus Points (Implemented Enhancements)

- **Theme Switching:** Supports switching between light and dark themes.
- **View Submitted Answers:** After submission, users can view their entered data in a read-only form.

## Setup Instructions

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/form_craft.git
    cd form_craft
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Ensure Flutter environment is set up:**
    ```bash
    flutter doctor
    ```

## How to Run

### On Mobile (Android)

1.  **Connect an Android device or start an emulator.**
2.  **Run the app:**
    ```bash
    flutter run
    ```

### On Web

1.  **Enable web support (if not already enabled):**
    ```bash
    flutter config --enable-web
    ``<img width="1911" height="897" alt="Screenshot 2025-08-16 170136" src="https://github.com/user-attachments/assets/04b67e99-c2bc-4853-9ca5-f4e2762e7399" />
<img width="1918" height="907" alt="Screenshot 2024-09-27 114150" src="https://github.com/user-attachments/assets/69e250ff-08a2-49f7-8671-0ef00a57f96e" />
<img width="1918" height="902" alt="lighttheme" src="https://github.com/user-attachments/assets/872272ba-d591-4224-99f5-f4fe7b925175" />
`
2.  **Run the app in a web browser:**
    ```bash
    flutter run -d chrome
    ```
    (You can replace `chrome` with your preferred web browser, e.g., `edge`, `firefox`.)

## Assumptions and Limitations

- **Data Persistence:** Currently, created forms are **not persisted** locally. If the application is closed or refreshed, all created forms will be lost. (This was an optional enhancement, and the implementation was reverted as per user request.)
- **Image/File Upload:** The feature to upload images or files as part of a question is not implemented.
- **User Authentication/Accounts:** There is no user authentication or account management system. All forms are managed locally within the application instance.
- **Backend Integration:** This is a purely client-side application; there is no backend for storing or processing form submissions externally.
- **Form Sharing:** Forms cannot be shared with other users.
- **Advanced Form Logic:** Conditional logic, branching, or complex validation rules are not implemented.
- **Accessibility:** While Flutter provides some accessibility features, a thorough accessibility audit has not been performed.
