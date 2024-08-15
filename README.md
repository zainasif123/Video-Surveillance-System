# Video Surveillance System

## Overview

The Video Surveillance System is an advanced AI-powered Android application designed to enhance safety by detecting violent or suspicious activities in real time. This system provides alerts and evidence of anomalies, such as fire, fighting, and road accidents, to authorized users. It is specifically engineered for environments where real-time monitoring and rapid response are crucial.
![Demo Screen](https://github.com/zainasif123/Video-Surveillance-System/blob/main/Thesis/Purple%20Pink%20Gradient%20Mobile%20Application%20Presentation.png)


## Features

- **Real-Time Detection**: Detects and alerts users of violent or suspicious activities as they occur.
- **Video Upload & Analysis**: Users can upload videos from their gallery for violence/anomaly detection.
- **Anomaly Evidence**: Provides evidence of detected anomalies to registered users.
- **Admin Functions**: Admins can manage user accounts, including creating, removing, and updating passwords.
- **User Authentication**: Handles both admin and user authentication securely.

## System Limitations

- **Detection Classes**: Only detects anomalies related to fire, fighting, and road accidents.
- **Camera Dependency**: The system’s effectiveness is contingent on proper camera functionality.
- **Limited Detection Conditions**: The system does not operate effectively in the dark and may struggle with weather changes or cluttered backgrounds.
- **Audio Violence**: Cannot detect violence involving audio.
- **Performance Variability**: Detection accuracy and performance may vary based on camera quality, positioning, and environmental conditions.
- **Upload & Processing Time**: Video upload time depends on internet speed and file size (typically 3 to 5 seconds). Processing time varies based on video size and quality.

## Functional Requirements

1. **FR01**: Admins can log in using their credentials.
2. **FR02**: Admins can create user accounts.
3. **FR03**: Admins can remove user accounts.
4. **FR04**: Admins can update their passwords.
5. **FR05**: Users can log in using credentials provided by admins.
6. **FR06**: Both admin and users can upload videos from the gallery.
7. **FR07**: Supports real-time violence detection.
8. **FR08**: Provides anomaly evidence to registered users.
9. **FR09**: Notifies authorized users upon detection of violence.

## Installation

1. Clone the repository: 
   ```bash
   git clone https://github.com/yourusername/videosurveillance-system.git
   ```
2. Navigate to the project directory:
   ```bash
   cd videosurveillance-system
   ```
3. Open the project in Android Studio and sync dependencies.

## Usage

1. Launch the application on an Android device.
2. Admins can log in and manage user accounts.
3. Users can log in, upload videos for analysis, and receive notifications on detected anomalies.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue if you have suggestions or improvements.

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

For any inquiries, please contact [asifzain981@gmail.com](mailto:asifzain981@gmail.com).
