export const token = process.env.EXPO_PUBLIC_MEETING_TOKEN; // you will this token from app.videosdk.live

// API call to create meeting
export const createMeeting = async ({ token }: { token: string }) => {
  const res = await fetch(`https://api.videosdk.live/v2/rooms`, {
    method: "POST",
    headers: {
      authorization: `${token}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({}),
  });

  const { roomId } = await res.json();
  console.log("room id", roomId);
  return roomId;
};
