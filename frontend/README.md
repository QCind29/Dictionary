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
Open terminal, go to frontend directory and run project
```bash
cd frontend
flutter pub get
```
### 3. Set up the Flask server
Go to server directory


