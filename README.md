
# react-native-parqal-gz-shoes-fixing

## Getting started

`$ npm install react-native-parqal-gz-shoes-fixing --save`

### Mostly automatic installation

`$ react-native link react-native-parqal-gz-shoes-fixing`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-parqal-gz-shoes-fixing` and add `RNParqalGzShoesFixing.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNParqalGzShoesFixing.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNParqalGzShoesFixingPackage;` to the imports at the top of the file
  - Add `new RNParqalGzShoesFixingPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-parqal-gz-shoes-fixing'
  	project(':react-native-parqal-gz-shoes-fixing').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-parqal-gz-shoes-fixing/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-parqal-gz-shoes-fixing')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNParqalGzShoesFixing.sln` in `node_modules/react-native-parqal-gz-shoes-fixing/windows/RNParqalGzShoesFixing.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Parqal.Gz.Shoes.Fixing.RNParqalGzShoesFixing;` to the usings at the top of the file
  - Add `new RNParqalGzShoesFixingPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNParqalGzShoesFixing from 'react-native-parqal-gz-shoes-fixing';

// TODO: What to do with the module?
RNParqalGzShoesFixing;
```
  