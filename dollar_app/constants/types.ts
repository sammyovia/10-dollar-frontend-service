import { StackNavigationProp, StackScreenProps } from "@react-navigation/stack";
import { RouteProp } from "@react-navigation/native";
import { BottomTabNavigationProp } from "@react-navigation/bottom-tabs";
import {
  NavigatorScreenParams,
  CompositeNavigationProp,
} from "@react-navigation/native";
// import { DoctorItem } from '../screens/main/Home/types';

export type AuthStackParamList = {
  Onboarding: undefined;
  Login: undefined;
  Register: undefined;
  ForgotPassword: undefined;
  MailBoxRegister: {
    text: string;
  };
  MailBox: {
    text: string;
  };
  Otp: {
    clientId: string;
  };
};

export type ContactDocParamList = {
  ContactDoctorHome: undefined;
  ContactDoctorSearch: undefined;
  ContactDoctorSelect: {
    data: {
      specialization: string;
      experience: string;
      name: string;
      condition: string;
    };
  };
  PersonalDoctor: undefined;
  DoctorPage: {
    doctor: any;
  };
  SubscriptionPage: {
    doctor: any;
  };
};

// Login
export type LoginScreenNavigationProp = StackNavigationProp<
  AuthStackParamList,
  "Login"
>;
export type LoginScreenScreenRouteProp = RouteProp<AuthStackParamList, "Otp">;
// Register
export type RegisterScreenNavigationProp = StackNavigationProp<
  AuthStackParamList,
  "Register"
>;

// ForgotPassword
export type ForgotPasswordScreenNavigationProp = StackNavigationProp<
  AuthStackParamList,
  "ForgotPassword"
>;

// MailBox
export type MailBoxScreenNavigationProp = StackNavigationProp<
  AuthStackParamList,
  "MailBox"
>;
export type MailBoxScreenScreenRouteProp = RouteProp<
  AuthStackParamList,
  "MailBox"
>;
// Otp
export type OtpScreenNavigationProp = StackNavigationProp<
  AuthStackParamList,
  "Otp"
>;

export type MainStackParamList = {
  HomeTab: NavigatorScreenParams<RootBottomTabParamList>;
  Consultant: undefined;
  DoctorsNearYou: undefined;
  Notification: undefined;
  Prescriptions: undefined;
  Prescription: {
    id: any;
  };
  DoctorProfile: {
    // doctor: DoctorItem
    doctor: any;
  };
  LaboratoryDetails: {
    laboratory: any;
  };
  LaboratoryTests: {
    laboratory: any;
  };
  doctorReport: undefined;
  doctorReportDetail: undefined;
  LabTestDetails: {
    laboratory: any;
    test: any;
  };
  LabAppointments: undefined;
  FilterDoctor: undefined;
  AppointmentDetails: {
    data: any;
  };
  ScannerView: undefined;
  Chat: {
    data: any;
  };
  Meeting: {
    meetingId: string;
    meetingName: string;
    token: string;
    webcamEnabled: boolean;
    micEnabled: boolean;
    profilePic?: string;
  };
  Board: undefined;
  WebView: {
    url: string;
  };
  UploadMedicalHistory: {
    user: any;
  };
  PaystackView: {
    data: any;
  };
  RaveView: {
    data: any;
  };
  PdfView: {
    user?: any;
    history?: string;
    link?: string;
    data?: any;
  };
  AccessControl: {
    user?: any;
    history?: string;
    link?: string;
    data?: any;
  };
  HistoryDetails: {
    history: string;
    user: any;
  };
  Settings: undefined;
  EditProfile: undefined;
  PersonalInfo: undefined;
  EmergencyServices: undefined;
  AddUserProfile: undefined;
  Billing: undefined;
  Laboratories: undefined;
  BillingPlans: undefined;
  Payment: {
    data: any;
  };
  HealthProvider: undefined;
  AddHealthProvider: undefined;
  ReferFriend: undefined;
  ChangePassword: undefined;
  ContactDocNavigator: undefined;
  AddOfflineSymptoms: undefined;
  AllOfflineSymptoms: undefined;
};

// HomeTab
export type HomeTabScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "HomeTab"
>;

// HomeTab
export type ContactDocNavigationProp = StackNavigationProp<
  ContactDocParamList,
  "ContactDoctorHome"
>;

// Consultant
export type ConsultantScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Consultant"
>;

// Notification
export type NotificationScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Notification"
>;

// DoctorProfile
export type DoctorProfileScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "DoctorProfile"
>;

export type DoctorProfileScreenScreenRouteProp = RouteProp<
  MainStackParamList,
  "DoctorProfile"
>;

// AppointmentDetails
export type AppointmentDetailsScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "AppointmentDetails"
>;

// Chat
export type ChatScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Chat"
>;

export type CallScreenProps = StackScreenProps<MainStackParamList, "Chat">;
// Chat
export type MeetingScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Meeting"
>;
export type MeetingScreenProps = StackScreenProps<
  MainStackParamList,
  "Meeting"
>;

// UploadMedicalHistory
export type UploadMedicalHistoryScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "UploadMedicalHistory"
>;

// History Details;
export type HistoryDetailsScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "HistoryDetails"
>;

// Settings;
export type SettingsScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Settings"
>;

// EditProfile;
export type EditProfileScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "EditProfile"
>;

// PersonalInfo;
export type PersonalInfoScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "PersonalInfo"
>;

// AddUserProfile;
export type AddUserProfileScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "AddUserProfile"
>;

// Billing;
export type BillingScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "Billing"
>;

// HealthProvider;
export type HealthProviderScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "HealthProvider"
>;

// ReferFriend;
export type ReferFriendScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "ReferFriend"
>;

// ChangePassword;
export type ChangePasswordScreenNavigationProp = StackNavigationProp<
  MainStackParamList,
  "ChangePassword"
>;

export type HistoryDetailsScreenRouteProp = RouteProp<
  MainStackParamList,
  "HistoryDetails"
>;

//
export type RootBottomTabParamList = {
  Home: undefined;
  Calendar: undefined;
  Messages: undefined;
  Profile: undefined;
};

// Home
export type HomeScreenNavigationProp = CompositeNavigationProp<
  BottomTabNavigationProp<RootBottomTabParamList, "Home">,
  StackNavigationProp<MainStackParamList>
>;

// Appointments
// export type AppointmentsScreenNavigationProp = CompositeNavigationProp<
//   BottomTabNavigationProp<RootBottomTabParamList, 'Appointments'>,
//   StackNavigationProp<MainStackParamList>
// >;

// Messages
export type MessagesScreenNavigationProp = CompositeNavigationProp<
  BottomTabNavigationProp<RootBottomTabParamList, "Messages">,
  StackNavigationProp<MainStackParamList>
>;

//  Profile
export type ProfileScreenNavigationProp = CompositeNavigationProp<
  BottomTabNavigationProp<RootBottomTabParamList, "Profile">,
  StackNavigationProp<MainStackParamList>
>;

// consultant Top tab

export type ConsultantTopTabParamList = {
  Upcoming: undefined;
  Past: undefined;
};
