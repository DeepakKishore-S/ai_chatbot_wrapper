# ai_chatbot_wrapper

A lightweight Flutter wrapper for integrating AI-powered chatbot functionality into your apps. Supports both real OpenAI GPT interactions and a mock service for local development.

---

## ✨ Features

- Plug-and-play chatbot UI (`ChatBotView`)
- Real OpenAI API integration via `OpenAIService`
- Mock AI service for local development and testing
- Fully customizable message styling and loading indicators

---

## 🚀 Installation

### 1. Add the dependency

#### Using Git (for remote repositories)

```yaml
dependencies:
  ai_chatbot_wrapper:
    git:
      url: https://github.com/DeepakKishore-S/ai_chatbot_wrapper  # Replace with your GitHub URL
```

#### Using Local Path (for local development/testing)

```yaml
dependencies:
  ai_chatbot_wrapper:
    path: ../path_to_your_package  # Replace with your local path
```

Then run:

```bash
flutter pub get
```

---

## 🔐 Configuration

### 2. Configure OpenAI API Key (Optional)

If using the OpenAI API:

```dart
final service = OpenAIService(apiKey: "your-api-key");
```

Get your API key from [OpenAI API Platform](https://platform.openai.com/).

If you're testing locally, use the mock service:

```dart
final service = MockAIService();
```

---

## 🧩 Example Usage

### 3. Integrate the Chatbot View

```dart
import 'package:flutter/material.dart';
import 'package:ai_chatbot_wrapper/ai_chatbot_wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("AI Chatbot Example")),
        body: ChatBotView(
          sendMessage: OpenAIService(apiKey: "your-api-key").sendMessage,
        ),
      ),
    );
  }
}
```

---

## 🧪 Local Testing with Mock Service

Use the `MockAIService` for testing without API calls:

```dart
ChatBotView(
  sendMessage: MockAIService().sendMessage,
)
```

---

## 🖼️ Example Screenshots (Add if available)

- Real Chatbot (OpenAI GPT)
- Mock Chatbot (Local Testing)

---

## 🧩 Troubleshooting

- **"Failed to connect to OpenAI API"**: Check your API key and internet connection.
- **"Error: Insufficient quota"**: Log in to [OpenAI](https://platform.openai.com/) and check your usage.

---

## 📄 License

MIT License. See the [LICENSE](LICENSE) file for details.

---

## 🤝 Contributing

We welcome contributions! Please submit a pull request or open an issue. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📬 Contact

For questions or suggestions, open an issue or reach out at [deepakkishore.sc@gmail.com](mailto:deepakkishore.sc@gmail.com).

---

Let me know if you'd like a badge section, example screenshots section with mockups, or support for publishing to `pub.dev`.