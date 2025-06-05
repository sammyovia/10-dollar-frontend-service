// import { SafeAreaView } from "@/components";
// import { useAuthContext } from "@/context/context";
// import { Redirect, router, Stack } from "expo-router";
// import { View, ActivityIndicator } from "react-native";

// const AuthLayout = () => {
//   const { isLoggedIn, isLoading } = useAuthContext();

//   if (isLoading)
//     return (
//       <View
//         style={{
//           flex: 1,
//           justifyContent: "center",
//           alignItems: "center",
//         }}
//       >
//         <ActivityIndicator size={"small"} />
//       </View>
//     );

//   if (!isLoading && isLoggedIn) return <Redirect href="/(tabs)/home" />;

//   return (
//     <SafeAreaView>
//       <Stack>
//         <Stack.Screen
//           name="login"
//           options={{
//             headerShown: false,
//           }}
//         />
//         <Stack.Screen
//           name="otp"
//           options={{
//             headerShown: false,
//           }}
//         />
//         <Stack.Screen
//           name="register"
//           options={{
//             headerShown: false,
//           }}
//         />
//         <Stack.Screen
//           name="forgotPassword"
//           options={{
//             headerShown: false,
//           }}
//         />
//       </Stack>
//     </SafeAreaView>
//   );
// };

// export default AuthLayout;

import { Stack } from "expo-router";
import { Text, TouchableOpacity } from "react-native";
import { router } from "expo-router";

const AuthLayout = () => {
  return (
    <Stack>
      {/* Admin Screen */}
      <Stack.Screen
        name="forgotPassword"
        options={{
          title: "Forgot Password",
          headerShown: true,
        }}
      />

      {/* Percent Screen */}
      <Stack.Screen
        name="login"
        options={{
          title: "Login",
          headerShown: true,
        }}
      />

      {/* Post Screen */}
      <Stack.Screen
        name="otp"
        options={{
          title: "Otp",
          headerShown: true,
        }}
      />

      {/* Profile Screen */}
      <Stack.Screen
        name="register"
        options={{
          title: "Register",
          headerShown: true,
        }}
      />

      
       </Stack>
  );
};

export default AuthLayout;

