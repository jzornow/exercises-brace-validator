# Bracket Validator Exercise

My response to [this problem from InterviewCake](https://www.interviewcake.com/question/python/bracket-validator?__s=gyigeu8pdg9do5gcoehd). A summary:

> You're working with an intern that keeps coming to you with JavaScript code that won't run because the braces, brackets, and parentheses are off. To save you both some time, you decide to write a braces/brackets/parentheses validator.

This ended up being easier than expected. There was lots of overengineering out of the gate, but then I remembered the ol' stack data structure from back in my CS days. After that, my solution came together really nicely.

I also used this as an excuse for a deep dive on RSpec's [`shared_examples` pattern](https://relishapp.com/rspec/rspec-core/v/2-6/docs/example-groups/shared-examples#providing-context-to-a-shared-group-using-a-block), which let me reuse the contexts and assertions I'd written for each type of brace tested. Saved me from a whole mess of copy-n-pasting. See the magic in [this commit](https://github.com/jzornow/exercises-brace-validator/commit/097ebc17ac0e9662d2ec97f7fa976513d61b8364).
