import:py dspy ;
import:py wikipedia ;
import:py from dspy.predict.parameter, Parameter ;

with entry {
    llm = dspy.OpenAI(model="gpt-4o");    
    dspy.settings.configure(lm=llm) ;
}

class Wikipedia:Parameter: {
    has name: str = "Search",
        input_variable: str = "query",
        desc: str = "takes a search query and returns summary from wikipedia";
    
    can init(k: Any=3){
        pass;
    }
    can __call__(query: Any) {
        return wikipedia.summary(query);
    }
}

with entry {
    get_answer = dspy.ReAct("question -> answer", tools=[Wikipedia()]);    
    question = "Where is Apple Headquaters located?";    
    result = get_answer(question=question);    
    print("Question: ", question) ;    
    print("Answer: ", result.answer) ;    
    question = "Who is Jason Mars?";    
    result = get_answer(question=question);    
    print("Question: ", question) ;    
    print("Answer: ", result.answer) ;
}
