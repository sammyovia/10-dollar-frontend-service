// import { getAuthState, IAuthState } from "@/store";
// import { useStorage } from "@/store/init";
// import { Notify } from "@/utils";
// import { router } from "expo-router";
// import { jwtDecode } from "jwt-decode";
// import React, {
//   createContext,
//   useContext,
//   useEffect,
//   useState,
//   ReactNode,
//   useMemo,
// } from "react";

// type authContextType = {
//   signIn: (token: string | null) => void;
//   signOut: () => void;
//   userDetails: IAuthState | null;
//   setUserDetails: (details: any) => void;
//   setUserToken: (token: any) => void;
//   userToken: string | null;
//   isLoggedIn: boolean;
//   isLoading: boolean;
// };

// const authContextDefaultValues: authContextType = {
//   signIn: () => {},
//   signOut: () => {},
//   userDetails: null,
//   setUserDetails: () => {},
//   setUserToken: () => {},
//   userToken: "",
//   isLoggedIn: false,
//   isLoading: false,
// };

// const AuthContext = createContext<authContextType>(authContextDefaultValues);

// export function useAuthContext() {
//   return useContext(AuthContext);
// }

// type Props = {
//   children: ReactNode;
// };

// export function AuthProvider({ children }: Props) {
//   const [userDetails, setUserDetails] = useState<IAuthState | null>(null);
//   const [userToken, setUserToken] = useState<string | null>(null);
//   const [isLoading, setIsLoading] = useState<boolean>(true);
//   const [isLoggedIn, setIsLoggedIn] = useState<boolean>(false);

//   // Function to check authentication status
//   const checkAuthStatus = async () => {
//     try {
//       const value = await getAuthState();
//       // console.log(value);
//       if (value) {
//         const decodedToken = jwtDecode(value.accessToken);
//         const isTokenExpired =
//           decodedToken.exp && decodedToken.exp * 1000 < Date.now();

//         const decodedChatToken = jwtDecode(value.chatToken);
//         const isChatTokenExpired =
//           decodedChatToken.exp && decodedChatToken.exp * 1000 < Date.now();

//         if (isTokenExpired || isChatTokenExpired) {
//           alert("Session expired!");
//           signOut();
//         } else {
//           setUserDetails(value);
//           setUserToken(value.accessToken);
//           setIsLoggedIn(true);
//         }
//       }
//     } catch (error) {
//       // console.error("Auth check failed: ", error);
//       Notify(
//         "Notification",
//         "Please, login to continue using HealthXP",
//         "warn"
//       );
//       signOut();
//     } finally {
//       setIsLoading(false);
//     }
//   };

//   // Run on mount to fetch auth state
//   useEffect(() => {
//     checkAuthStatus();
//   }, []); // Runs only once on mount

//   const signIn = async (token: string | null) => {
//     if (token) {
//       await useStorage.setItem("accessToken", token);
//       setUserToken(token);
//       setIsLoggedIn(true);
//       checkAuthStatus();
//     }
//   };

//   // Sign Out Function
//   const signOut = async () => {
//     setIsLoading(true);
//     await useStorage.removeItem("accessToken");
//     await useStorage.removeItem("userInfo");
//     setUserToken(null);
//     setUserDetails(null);
//     setIsLoggedIn(false);

//     useStorage.getItem("onboarded").then(async (value) => {
//       if (value) {
//         router.replace("/(auth)/login");
//       } else {
//         router.replace("/");
//       }
//     });
//     setIsLoading(false);
//   };

//   // Memoized Context Value to avoid unnecessary re-renders
//   const authContextValue = useMemo(
//     () => ({
//       signIn,
//       signOut,
//       userDetails,
//       setUserDetails,
//       userToken,
//       setUserToken,
//       isLoggedIn,
//       isLoading,
//     }),
//     [userDetails, userToken, isLoggedIn, isLoading] // Only updates when these states change
//   );

//   return (
//     <AuthContext.Provider value={authContextValue}>
//       {children}
//     </AuthContext.Provider>
//   );
// }

// export default AuthProvider;
