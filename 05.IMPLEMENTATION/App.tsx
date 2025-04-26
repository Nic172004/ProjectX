import React from 'react';
import { StatusBar, LogBox } from 'react-native';
import { AppNavigator } from './src/navigation';
// Import necessary polyfills and dependencies for React Navigation
import 'react-native-gesture-handler';
import { enableScreens } from 'react-native-screens';

// Enable screens for better performance
enableScreens();

// Ignore specific warnings
LogBox.ignoreLogs([
  'Unsupported top level event type "topInsetsChange" dispatched',
  'Non-serializable values were found in the navigation state',
]);

const App = () => {
  console.log('App component rendering');
  
  return (
    <>
      <StatusBar barStyle="dark-content" backgroundColor="#F5F7FA" />
      <AppNavigator />
    </>
  );
};

export default App;
