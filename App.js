import React, { Component } from 'react';
import ReactNative, {
  Platform,
  StyleSheet,
  Text,
  View,
  requireNativeComponent,
  TouchableWithoutFeedback,
  UIManager,
  Dimensions,
  FlatList
} from 'react-native';


export default class App extends Component<{}> {

  render() {
    return (
      <View style={styles.container}>
        <View style={{ flex: 4 }}>
          <SwiftComponent  width={Dimensions.get('window').width} style={{flex: 1}}
            ref={(component) => this.mySwiftComponentInstance = component } />
        </View>
        <View style={styles.flatList}>
          <FlatList
          ItemSeparatorComponent={() => (
            <View style={{ width: 3, height: 100 }} />
          )}
            style={{ flex: 1 }}
            data={filtersData}
            renderItem={({ item }) => (
              <TouchableWithoutFeedback onPress={this.onPressButton.bind(this, item)}>
              <View style={styles.listItems}>
                 <SwiftComponent height={130} width={130} filterName={item.key} style={{ flex: 1 }}/>
              </View>
              </TouchableWithoutFeedback>
            )}
            horizontal
          />
        </View>
      </View>
    );
  }

  onPressButton(item) {
    UIManager.dispatchViewManagerCommand(
      ReactNative.findNodeHandle(this.mySwiftComponentInstance),
      UIManager.SwiftComponent.Commands.updateValueViaManager,
      [item.key]
    );
  }

}

const filtersData = [
  { key: 'CIPhotoEffectMono' },
  { key: 'CIPhotoEffectNoir' },
  { key: 'CIPhotoEffectProcess' },
  { key: 'CIPhotoEffectTonal' },
  { key: 'CIPhotoEffectTransfer' },
  { key: 'CISepiaTone' },
  { key: 'CIVignette' }
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    backgroundColor: '#000000'
  },
  listItems: {
    height: 130,
    width: 130,
    backgroundColor: '#ffffff',
    paddingRight: 20
  },
  button: {
    marginTop: 50,
    width: 120,
    height: 60,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#F0F',
    backgroundColor: '#FFF'
  },
  flatList: {
    paddingTop: 10,
    paddingBottom: 10,
    flex: 1
  }
});

const SwiftComponent = requireNativeComponent('SwiftComponent');
