# eliza-chatbot-lisp
Implementation of the ELIZA chatbot in Common Lisp, using pattern matching, wildcard substitution, and rule-based response generation. Developed as part of an Artificial Intelligence module.

# 🧠 ELIZA Chatbot (LISP)

This is a mini-project developed during an Artificial Intelligence module. It reproduces a simplified version of the famous ELIZA chatbot using **Common Lisp**, with features such as pattern matching, wildcard management, substitutions, and rule-based response generation.

---

## 📌 Project Overview

- Language: **Common Lisp**
- Theme: **Rule-based chatbot (ELIZA)**
- Technologies: Text-based pattern matching, variable binding, substitution, random response selection
- Duration: 3 lab sessions (6h)

---

## 🚀 Features

- Pattern recognition with `match`, `wildcard`, `match-eq`
- Variable binding and substitution with `bind`, `lookup`, `subs`
- Perspective shifting using `swap` and `*viewpoint*` table
- Randomized response selection with `random-elt`
- Continuous conversation loop via the `eliza` function

---

## 🗂️ Project Structure

eliza-chatbot-lisp/ ├── eliza.lisp # Main source code ├── rules.lisp # Chatbot rules and responses ├── test-cases.lisp # Example user inputs and tests ├── README.md # Documentation └── rapport_eliza.pdf # Final project report (French)


---

## ▶️ Getting Started

To run the chatbot:

1. Install a Common Lisp interpreter (e.g. SBCL or CLISP)
2. Open your terminal
3. Load the project:

```bash
sbcl --load eliza.lisp
```

4. Run the main function:

```bash
(eliza)
```


To quit, type bye.

##🧪 Example Interaction

```bash

> (eliza)

} hello
HELLO. HOW CAN I HELP ?

} i feel sad
DO YOU OFTEN FEEL SAD ?

} i want to be happy
WHY DO YOU WANT TO BE HAPPY ?

} bye
Goodbye!
```


##👩‍💻 Author
Nissrine Elabjani
2nd Year Engineering Student – Embedded Systems
Université Paris Cité – Denis Diderot Engineering School
📍 Paris, France
📧 nissrine.elabjani@gmail.com

##📄 License
This project is for academic purposes only and follows the license terms described in the original ELIZA project instructions.

