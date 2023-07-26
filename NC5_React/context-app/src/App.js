import ColorContext, {ColorProvider} from "./context/color";
import ColorBox from "./components/ColorBox";
import SelectColor from "./components/SelectColor";


function App() {
    return (
        //<ColorContex.Provider value={값}>
        <ColorProvider value={{color: 'blue'}}>
            <div>
                <SelectColor></SelectColor>
                <ColorBox></ColorBox>
            </div>
        </ColorProvider>
    );
}

export default App;
