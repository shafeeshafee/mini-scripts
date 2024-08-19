#!/bin/bash

echo -e "Somewhere near a smoky mountaintop, there lived a wizard who was known as 'Gecko the Firemaker', or simply Gecko. \n

Gecko was 3,395 years old and had seen it all. Throughout the three millenia he lived, he looked for weary souls to teach the art of magic to. It didn't matter how old, what walk of life, or the color of their toenail. But whoever he chose, there was a certain fire within that individual that could shine up the entire earth--that is, if they so wished!\n

On a frosty morning at the Pinebush hiking range, you ($USER) walk down the trail. You have just received a lavish job offer at Amazon as a DevOps engineer. With a 6-figure salary, PTO, and bonuses, you were very stoked and decided to go on a hiking trip to celebrate.  \n

As you continue down the trail, you suddenly notice a man sitting atop a boulder. Clad in bergundy robe, holding a staff and deep silver hair...


Is this danger? Or is this mere hallucination?\n

...\n"

newline() {
    echo -e "\n"
    echo "----------------------------------------------"
    echo -e "\n"
}

protagonist() {
    echo "1.) Ask who they are."
    echo -e "2.) Run away as fast as possible.\n"
    read -p "Enter your choice (1-2):" choice

    case $choice in
        1) who_are_they;;
        2) run_away;;
        *) echo "Invalid choice"
    esac
}

who_are_they() {
    newline
    echo -e "Me: \"W-who are you?!\n"
    echo -e "You tremble, there is a certain presence in that old man that reverberates power... prestige.\n"
    echo -e "Gecko: \"I am Gecko the Firemaker. I heard about your recent job offer and I come to you with one better! Join me as my apprentice. You will learn wizardry, magic, dragonriding, and all the more! What say you, $USER?\n"
    echo "1) Join the wizard. When's something like this ever going to happen again?"
    echo -e "2) Politely decline. It might just be a crazy guy in a robe.\n"
    read -p "Enter your choice (1-2): " user_decision

    if [[ user_decision == "1" ]]; then
        newline
        echo -e "Me: \"Fine. I'll join you on this endeavor, Gecko.\"\n"
        echo "The wizard smiles, clicks his staff on the ground below, and POOF! You are transported to The Firesmith, a wizardry academy."
        wizard_offer
    else
        newline
        echo -e "Me: \"No thanks pops, but I refuse. I'm going to become a DevOps engineer!\n"
        echo "The wizard nods, clicks his staff to the ground and disappears."
        devops_offer
        newline
    fi
}

run_away() {
    newline
    echo -e "You run away, retracing your steps to the entrance of the hike, grab your car and drive home.\n"

    echo "The end."
    newline
}

wizard_offer() {
    echo "Wizard offer"
}

devops_offer() {
    newline
    echo "devops"
}


protagonist
