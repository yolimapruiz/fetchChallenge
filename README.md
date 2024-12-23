### Steps to Run the App
The app is going to make its firt call to the api by deafult and it would cache the recipe list.
To visualize what happens when it recives en empty recipe list or malformed data please comment the good endpoint in the reposiry and uncomment 
the want you want to visualize

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I choose to focus on the networking layer to ensure the app could handle a variety of data scenarios (e.g valid data, empty data, malformed data). 
This is a critical part of the app because it ensures robust communication with the API, proper error handling, and smooth data flow to others parts
of the application.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I allocated 8hrs, allocted as follows
3hrs designing and implementing the networking layer
2 hrs Creating models and implementing a mapper to transform API data into UI-friendly models 
1 hr implementing the viewModel
1 hr implementing the UIs
1 hr implementing the composition root and connecting all the layers
3 hrs implementing Unit tests 
1 hrs adding and handling the empty and corrupt data edge cases 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Yes, I made trade-off.
1.I prioritized funtional error handling over detailed UI designs for the error states
2.I choose to implement a simple state management system instead of using more advances frameworks like Combine

### Weakest Part of the Project: What do you think is the weakest part of your project?
How the UI looks when empty data or malformed data are encountered

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
Given more time I would improve the user interface for empty and error states
