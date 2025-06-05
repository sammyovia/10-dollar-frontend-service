import { Stack } from "expo-router";
import { Text, TouchableOpacity } from "react-native";
import { router } from "expo-router";

const ViewLayout = () => {
  return (
    <Stack>
      {/* Admin Screen */}
      <Stack.Screen
        name="admin"
        options={{
          title: "Admin",
          headerShown: true,
        }}
      />

      {/* Percent Screen */}
      <Stack.Screen
        name="percent"
        options={{
          title: "Percent",
          headerShown: true,
        }}
      />

      {/* Post Screen */}
      <Stack.Screen
        name="post"
        options={{
          title: "Post",
          headerShown: true,
        }}
      />

      {/* Profile Screen */}
      <Stack.Screen
        name="profile"
        options={{
          title: "Profile",
          headerShown: true,
        }}
      />

      {/* Request Payout Screen */}
      <Stack.Screen
        name="requestPayout"
        options={{
          title: "Request Payout",
          headerShown: true,
        }}
      />

      {/* Stakes Screen */}
      <Stack.Screen
        name="stakes"
        options={{
          title: "Stakes",
          headerShown: true,
        }}
      />
      {/* User Screen */}
      <Stack.Screen
        name="users"
        options={{
          title: "Users",
          headerShown: true,
        }}
      />

      {/* Upload Videos Screen */}
      <Stack.Screen
        name="uploadVideos"
        options={{
          title: "Upload Videos",
          headerShown: true,
        }}
      />

        {/* Videos Screen */}
      <Stack.Screen
        name="videos"
        options={{
          title: "Videos",
          headerShown: true,
        }}
      />
      
       </Stack>
  );
};

export default ViewLayout;
