# QR Code Generator Flutter App

A powerful and flexible Flutter app to generate various types of QR codes including:
- URLs
- Emails
- Phone numbers
- SMS
- vCards
- Files
- Wi-Fi Credentials
- Calendar Events
- Geo Coordinates
- and more...

## 🚀 Features

- 🔄 Dynamic input fields based on selected QR type.
- 📷 Add a logo/image in the center of the QR code.
- 🖼️ Preview the generated QR code in real-time.
- 📤 Share the QR code via email or other apps.
- 💾 Download/Save the generated QR as an image.
- 🎨 Customizable QR styling options.

## 📱 Screenshots

*(Add screenshots here once available)*

## 📦 Dependencies

Make sure to include the following in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  qr_flutter: ^4.0.0
  file_picker: ^6.1.1
  image_picker: ^1.0.7
  path_provider: ^2.1.1
  share_plus: ^7.2.1
  email_launcher: ^0.0.1+2
  permission_handler: ^11.0.1
```

> You may also need to add platform-specific permissions for file and media access. See the setup guides for `image_picker`, `permission_handler`, and `file_picker`.

## 🔧 Getting Started

1. **Clone the repo:**

   ```bash
   git clone https://github.com/yourusername/qr-code-generator-flutter.git
   cd qr-code-generator-flutter
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

## 🛠️ Supported QR Types

| QR Type    | Inputs Required                       |
|-----------|----------------------------------------|
| URL       | Link                                   |
| Email     | Email address                          |
| Phone     | Phone number                           |
| SMS       | Phone number, Message                  |
| Text      | Custom text                            |
| File      | Pick file (generates file path/URI QR) |
| vCard     | Full name, Email, Phone, Address       |
| Wi-Fi     | SSID, Password, Security type          |
| Calendar  | Title, Start/End Time, Location        |
| Geo       | Latitude, Longitude                    |

## 📂 Folder Structure

```
lib/
├── main.dart          # Entry point of the app
├── home_page.dart     # Main UI and QR generation logic
└── widgets/           # Optional UI components (if any)
```

## 💡 Customization

- You can easily add new QR types by extending the switch-case in `generateQRCodeData()`.
- Style your QR codes using `qr_flutter`'s custom painters or add animations.

## 📬 Contact

For suggestions, issues or collaborations, feel free to connect with the developer:

**Sufiyan**  
Final Year AI & Data Science Student  
🌐 [Portfolio](https://gcafsufiyan.netlify.app)  
📧 sufiyandev@gmail.com
