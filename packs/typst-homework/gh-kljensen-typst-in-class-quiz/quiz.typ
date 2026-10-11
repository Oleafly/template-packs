#import "quiz_template.typ": quiz

#show: quiz.with(
  title: "MGT802 Quiz: Neural Networks"
)

+ Activations in one layer of a neural network are
  - [x] Based on a weighted sum of the activations in the previous layer
  - [ ] Randomly determined
  - [ ] Set by the developer who is creating the neural network
  - [ ] Independent of all the other layers in the neural network

+ In the 2Blue1Brown videos, the author's network for recongizing hand-written digits has about 13,000 parameters. These are _roughly_...
  - [ ] The number of neurons
  - [x] The number of connections between neurons
  - [ ] The number of inputs
  - [ ] The number of outputs

+ What is the significance of the "weights" and "biases" in a neural network as discussed in the video?
  - [x] Weights determine the pixel pattern a neuron is picking up on, and biases indicate how high the weighted sum needs to be before the neuron becomes meaningfully active.
  - [ ] Weights and biases are the types of neurons present in a neural network.
  - [ ] Biases are responsible for recognizing edges while weights recognize patterns.
  - [ ] Weights and biases are external inputs required to initiate the neural network.

+ What is the primary purpose of the sigmoid function in the neural network described in the video?
  - [ ] To detect edges in the image input.
  - [ ] To multiply the weighted sum of pixel values.
  - [x] To squish the real number line into the range between 0 &  1 for neuron activation.
  - [ ] To increase the complexity of the network for better digit recognition.

+ Which of the following best describes gradient descent in the context of neural networks as discussed in the video?
  - [ ] A function with 784 inputs and 10 outputs defined in terms of all of the weighted sums.
  - [ ] A method to initialize all weights and biases randomly in the network.
  - [x] A process of repeatedly nudging an input of a function by some multiple of the negative gradient to minimize a cost function.
  - [ ] A method to visualize the weights of the connections between neurons in different layers.

+ What is the primary purpose of a cost or "loss" function in a neural network as described in the video?
  - [ ] To initialize the weights and biases of the network.
  - [ ] To visualize the transitions from one layer of neurons to the next.
  - [x] To provide a measure of how well the network is performing based on training examples.
  - [ ] To categorize the output into one of the 10 digits.

+ According to the video, why is the concept of gradient descent crucial in the training of neural networks?
  - [ ] It allows the network to memorize the training data perfectly.
  - [x] It facilitates the minimization of a cost function to improve the network's performance.
  - [ ] It randomly initializes the weights and biases to start the training process.
  - [ ] It helps in visualizing the weights between different layers of neurons.

+ If $f(x) = (2x + 3)^5$, find $f'(x)$ using the chain rule.
  - [ ] $(2x + 3)^5$
  - [ ] $2(2x + 3)^4$
  - [x] $10(2x + 3)^4$
  - [ ] $5(2x + 3)^4$

+ Imagine $A$ is a 2x3 matrix and $B$ is a 3x5 matrix. What are the dimensions of $A B$?
  - [ ] 3x3
  - [x] 2x5
  - [ ] 3x5
  - [ ] 5x2
  - [ ] 5x3

+ How does backpropagation use individual training examples to adjust the weights and biases in a neural network?
  - [x] By computing how each training example would like to nudge the weights and biases, then averaging these desired changes across all examples.
  - [ ] By randomly shuffling the training examples and selecting one to adjust the weights and biases.
  - [ ] By directly modifying the activations of neurons based on each training example.
  - [ ] By creating new layers in the network based on the complexity of each training example.

+ What is the purpose of using mini-batches in the context of stochastic gradient descent as explained in the video?
  - [ ] To ensure that the network converges to a global minimum of the cost function.
  - [ ] To increase the accuracy of the gradient calculation by considering all training examples.
  - [x] To take steps according to a subset of training data, providing a good approximation of the gradient while speeding up computation.
  - [ ] To create a new cost function based on subdivided data.

+ The videos suggests that when adding more neurons to each layer of the network, what primarily changes in the backpropagation calculus?
  - [ ] The fundamental equations of backpropagation change.
  - [x] More indices are introduced to keep track of various neurons within a layer.
  - [ ] The chain rule no longer applies in the same way.

+ What is the meaning of life?
  - [x] 42
  - [x] programming
  - [x] machine learning
