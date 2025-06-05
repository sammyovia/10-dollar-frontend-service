/* eslint-disable @typescript-eslint/no-unsafe-call */
import { Dimensions } from "react-native";
import {
  widthPercentageToDP as wdp,
  heightPercentageToDP as hdp,
} from "react-native-responsive-screen";

// export let customWidth = Dimensions.get('screen').width;
// export let customHeight = Dimensions.get('screen').height;

export const customWidth = 375;
export const customHeight = 812;

export const wp = (value: number): number => {
  const dimension = (value / customWidth) * 100;
  return wdp(`${dimension}%`);
};
export const hp = (value: number): number => {
  const dimension = (value / customHeight) * 100;
  return hdp(`${dimension}%`);
};
