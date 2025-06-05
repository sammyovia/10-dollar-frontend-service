import { Dimensions, StatusBar, Platform, PixelRatio, Easing, UIManager, LayoutAnimation } from 'react-native';
import { CardStyleInterpolators } from '@react-navigation/stack';

export const layoutAnimation = () => {
    if (Platform.OS === 'android') {
      UIManager.setLayoutAnimationEnabledExperimental &&
      UIManager.setLayoutAnimationEnabledExperimental(true)
    }
    LayoutAnimation.configureNext(LayoutAnimation?.Presets?.easeInEaseOut)
}
  
export const springLayoutAnimation = () => {
    if (Platform.OS === 'android') {
      UIManager.setLayoutAnimationEnabledExperimental &&
      UIManager.setLayoutAnimationEnabledExperimental(true)
    }
    LayoutAnimation.configureNext(LayoutAnimation?.Presets?.spring)
}
  
export const linearLayoutAnimation = () => {
    if (Platform.OS === 'android') {
      UIManager.setLayoutAnimationEnabledExperimental &&
      UIManager.setLayoutAnimationEnabledExperimental(true)
    }
    LayoutAnimation.configureNext(LayoutAnimation?.Presets?.linear)
}

const springTransitionSpec = {
  open: {
    animation: 'spring',
    config: {
      duration: 250,
      easing: Easing.inOut(Easing.ease),
    },
  },
  close: {
    animation: 'timing',
    config: {
      duration: 250,
      easing: Easing.inOut(Easing.ease),
    },
  },
};

export const ModalTransition = {
  transitionSpec: springTransitionSpec,
  title: "",
  cardStyleInterpolator: CardStyleInterpolators.forModalPresentationIOS,
  headerShown: false
}