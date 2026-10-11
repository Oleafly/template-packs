#import "exam.typ": exam

#show: exam.with(
    exam_title: "Sample exam",
    subtitle: "Sample subtitle", 
    nrows: 2, 
    ncols: 2, 
    points_per_multiple_choice: 1, 
    points_per_short_response: 1, 
    points_per_long_response: 5, 
    multiple_choice: (

        (
            body: [
                Up to how many answer choices may each multiple choice question
                have?
            ]
            , a: [1]
            , b: [2]
            , c: [3]
            , d: [4]
            , solution: "D"
        ),

        (
            body: [
                Can we write true or false questions?
            ]
            , a: [True]
            , b: [False]
            , solution: "A"
        ),

        (
            body: [
                How many answer choices are there for this question?
            ]
            , a: [One]
            , solution: "A"
        ),

    ),

    short_response: (

        (
            body: [
                Why is having a template like this useful?
            ]
            , solution: [
                It allows us to write all our questions and their solutions in
                one document, without needing to maintain separate documents
                for exam questions, solutions, and student answer sheets. This
                reduces the possibility that we make an error while creating an
                exam while also speeding up the process to make an exam.
            ]
        ),

    ),

    long_response: (

        (
            body: [Write a hello world program in C.]
            , solution: [

                ```c
                #include <stdio.h>

                int main(int argc, char **argv) {
                    printf("Hello, world!\n");
                    return 0;
                }
                ```

            ]
        ),

    )

)
