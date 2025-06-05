import * as yup from "yup";

// export const LoginSchema = yup.object().shape({
//   clientId: yup.string()
//   // .required('username is required'),
//   .required('Incorrect User ID'),
//   password: yup
//     .string()
//     .min(8, ({ min }) => `Password must be at least ${min} characters`)
//     // .required('Password is required'),
//     .required('Incorrect Password'),
// });
export const LoginSchema = yup.object().shape({
  email: yup
    .string()
    .email()
    // .required('username is required'),
    .required("Invalid email address"),
  password: yup
    .string()
    .min(8, ({ min }) => `Password must be at least ${min} characters`)
    // .required('Password is required'),
    .required("Incorrect Password"),
});

/**
 *  firstName: string;
  lastName: string;
  phoneNumber: string;
  sex: string;
  email: string;
  password: string;
  confirmPassword: string;
  role: string;
  city: string;
  country: string;
  userName: string;
  dateOfBirth: Date;
 * 
 */

export const RegisterSchema = yup.object().shape({
  firstName: yup.string(),
  lastName: yup.string(),
  phoneNumber: yup.string().required("phone is required"),
  // sex: yup.string(),
  email: yup.string().email().required("email is required"),
  password: yup
    .string()
    .min(8, ({ min }) => `password must be at least ${min} characters`)
    .required("password is required"),
  confirmPassword: yup
    .string()
    .oneOf([yup.ref("password")], "Passwords must match")
    .required("confirm password is required"),
  // role: yup.string(),
  city: yup.string().required("City is required").nullable(),
  country: yup.string().required("Country is required"),
  userName: yup.string().required("Username is required"),
  dateOfBirth: yup.date(),
});

export const EditProfileSchema = yup.object().shape({
  firstName: yup.string().required("First name is required"),
  lastName: yup.string().required("Last name is required"),
  phoneNumber: yup.string().required("Phone number is required"),
  email: yup.string().email().required("Email is required"),
  profilePic: yup.string(),
  country: yup.string().required("Country is required"),
  city: yup.string().required("City is required").nullable(),
});

export const OfflineSymptomSchema = yup.object().shape({
  user_id: yup.string().required("User Id"),
  date: yup.string().required("Start Date is required"),
  end_date: yup.string(),
  symptom: yup.string().required("Symptom is required"),
  body_part: yup.string().required("Body part is required"),
  degree_of_symptom: yup.string().required("Degree of symptom is required"),
  note: yup.string(),
});

export const ContactDocSchema = yup.object().shape({
  name: yup.string(),
  specialization: yup.string().required("Speciality is required").nullable(),
  experience: yup.string().required("Band is required").nullable(),
  condition: yup.string().required("Medical condition is required"),
});

export const ForgotPasswordSchema = yup.object().shape({
  email: yup.string().email().required("email is required"),
});

export const VerifyForgotPasswordSchema = yup.object().shape({
  token: yup.string().required("Token is required"),
  password: yup
    .string()
    .min(8, ({ min }) => `password must be at least ${min} characters`)
    .required("password is required"),
  confirmPassword: yup
    .string()
    .oneOf([yup.ref("password")], "Passwords must match")
    .required("confirm password is required"),
});

export const OTPSchema = yup.object().shape({
  otp: yup.string().required("otp is required"),
});

export const ChangePasswordSchema = yup.object().shape({
  email: yup.string().email().required("email is required"),
  oldPassword: yup
    .string()
    .min(8, ({ min }) => `password must be at least ${min} characters`)
    .required("Current password is required"),
  newPassword: yup
    .string()
    .min(8, ({ min }) => `Password must be at least ${min} characters`)
    .required("Password is required"),
  confirmNewPassword: yup
    .string()
    .oneOf([yup.ref("newPassword")], "Passwords must match")
    .required("Confirm your password"),
});

export const ChangePhoneNumberSchema = yup.object().shape({
  currentPhoneNumber: yup.string().required("Current phone number is required"),
  newPhoneNumber: yup.string().required("New phone number is required"),
  password: yup
    .string()
    .min(8, ({ min }) => `Password must be at least ${min} characters`)
    .required("Password is required"),
});

export const ProfileSchema = yup.object().shape({
  fullName: yup.string().required("Full name is required"),
  userName: yup.string().required("username is required"),
  email: yup.string().email("Invalid email").required("email is required"),
  password: yup
    .string()
    .min(8, ({ min }) => `Password must be at least ${min} characters`)
    .required("Password is required"),
  confirmPassword: yup
    .string()
    .oneOf([yup.ref("password")], "Passwords must match")
    .required("confirm password is required"),
});

export const RegisterInfoSchema = yup.object().shape({
  fullName: yup.string().required("Full name is required"),
  userName: yup.string().required("username is required"),
  email: yup.string().email("Invalid email").required("email is required"),
  password: yup
    .string()
    .min(8, ({ min }) => `Password must be at least ${min} characters`)
    .required("Password is required"),
  confirmPassword: yup
    .string()
    .oneOf([yup.ref("password")], "Passwords must match")
    .required("confirm password is required"),
});

export const FlagCommentSchema = yup.object().shape({
  comment: yup.string().required("comment is required"),
});

export const EditProfileSchema2 = yup.object().shape({
  fullName: yup.string().required("Full name is required"),
  userName: yup.string().required("username is required"),
  email: yup.string().email("Invalid email").required("email is required"),
});

export const AppointmentSchema = yup.object().shape({
  doctorId: yup.string().required("Doctor ID is required"),
  patientId: yup.string().required("Doctor ID is required"),
  date: yup.date().nullable().required("Date is required"),
  // slot: yup.string().required("Slot time is required"),
  // appointmentEnd: yup.date().nullable().required("Appointment end time is required"),
});

export const LabAppointmentSchema = yup.object().shape({
  labId: yup.string().required("Laboratory ID is required"),
  testId: yup.string().required("Test ID is required"),
  date: yup.date().nullable().required("Date is required"),
  slot: yup.number().nullable().required("Slot time is required"),
  amount: yup.number().nullable().required("Amount is required"),
  service_type: yup.string().required("Service Type is required"),
  description: yup.string().required("Enter test specifics"),
});
