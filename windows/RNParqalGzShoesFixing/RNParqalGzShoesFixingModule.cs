using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Parqal.Gz.Shoes.Fixing.RNParqalGzShoesFixing
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNParqalGzShoesFixingModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNParqalGzShoesFixingModule"/>.
        /// </summary>
        internal RNParqalGzShoesFixingModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNParqalGzShoesFixing";
            }
        }
    }
}
