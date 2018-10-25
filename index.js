const antlr4 = require('antlr4');
const VIASearchLexer = require('./dsl/VIASearchLexer');
const VIASearchParser = require('./dsl/VIASearchParser');
const input = '[user id=admin /] [tag id=ronaldo /] goal of the year [tag id=juventus /]'
const chars = new antlr4.InputStream(input);
const lexer = new VIASearchLexer.VIASearchLexer(chars);
const tokens = new antlr4.CommonTokenStream(lexer);
const parser = new VIASearchParser.VIASearchParser(tokens);
parser.buildParseTrees = true;
const tree = parser.searchElements();
for (let i = 0; i < tree.children.length; i++) {
    let child = tree.children[i];
    const nodeType = parser.ruleNames[child.ruleIndex];
    if (nodeType == "searchElement") {
        const searchElement = child.children[0];
        const searchElementType = parser.ruleNames[searchElement.ruleIndex];
        if (searchElementType == "searchElementTag") {
            for (let i = 0; i < searchElement.children.length; i++) {
                const searchAttribute = searchElement.children[i];
                console.log(searchAttribute.getText());
            }
        } else if (searchElementType == "searchElementRaw") {
            console.log(child.getText());
        }
    }
}