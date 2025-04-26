import { registerRootComponent } from 'expo';
import { LogBox } from 'react-native';

// Ignore the specific warning causing problems
LogBox.ignoreLogs([
  'Unsupported top level event type "topInsetsChange" dispatched',
  'VirtualizedLists should never be nested inside plain ScrollViews'
]);

import App from './App';

// registerRootComponent calls AppRegistry.registerComponent('main', () => App);
// It also ensures that whether you load the app in Expo Go or in a native build,
// the environment is set up appropriately
registerRootComponent(App);
