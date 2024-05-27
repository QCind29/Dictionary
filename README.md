# Image Insight

This is a mobile application built with Flutter that allows users to upload images, detect objects within them, and retrieve relevant information from Wikipedia about those objects. The app integrates with a Flask server for image processing and information retrieval.

## Features

- **Image Selection**: Users can select images from their device's gallery or capture new photos using the device's camera.
- **Object Detection**: Uploaded images are processed on a Flask server using computer vision techniques to detect objects within them.
- **Wikipedia Integration**: The app retrieves Wikipedia information about detected objects from the Flask server and displays it to the user.

## Requirements
- Flutter SDK (minSDKversion 21)
- Python 3.x
- Flask
- ngrok (for hosting the Flask server)

## Getting Started

### 1. Clone this project
```bash
git clone https://github.com/QCind29/Image_Insight.git
```
### 2. Set up the Flutter project by navigating to the project directory and running:
- Open terminal, go to **frontend** directory and run project
```bash
cd frontend
flutter pub get
```
### 3. Set up the Flask server
- Go to **server** directory
- Create a virtual environment:
```bash
  cd server
  python3 -m venv venv
  source venv/bin/activate
```
- Install dependencies:
```bash
pip install -r requirements.txt
```
### 4. Install ngrok for hosting the Flask server:

- Download ngrok from the official website: [ngrok](https://ngrok.com/).
- Extract the downloaded ngrok executable to a directory in your system.
 
### 5. Run the Flask server:
```bash
cd server
python app.py
```
### 6 .Expose the Flask server using ngrok:
```bash
./ngrok http 5000
```
- Note: Replace 5000 with the port number on which your Flask server is running if it's different.

### 7. Copy the ngrok forwarding URL (e.g., http://123abc.ngrok.io) to use in the Flutter app.
- Replcae this url to **frontend/lib/Api_Service/Api_service.dart** at line 8.
-  ...
  class ApiService {
  static String _baseURL = "https://06e0-1-55-41-26.ngrok-free.app";
  ...
  }
### 8. Run the flutter project
```bash
cd frontend
flutter run
```







