#!/bin/bash

echo -e "Somewhere near a smoky mountaintop, there lived a wizard who was known as 'Gecko the Firemaker', or simply Gecko. \n

Gecko was 3,395 years old and had seen it all. Throughout the three millenia he lived, he looked for weary souls to teach the art of magic to. It didn't matter how old, what walk of life, or the color of their toenail. But whoever he chose, there was a certain fire within that individual that could shine up the entire earth--that is, if they so wished!\n

On a frosty morning at the Pinebush hiking range, you ($USER) walk down the trail. You have just received a lavish job offer at Amazon as a DevOps engineer. With a 6-figure salary, PTO, and bonuses, you were very stoked and decided to go on a hiking trip to celebrate.  \n

As you continue down the trail, you suddenly notice a man sitting atop a boulder. Clad in bergundy robe, holding a staff and deep silver hair...


Is this danger? Or is this mere hallucination?\n

...\n"

newline() {
    echo -e "\n"
    echo "=============================================="
    echo -e "\n"
}

get_valid_input() {
    local prompt="$1"
    local max_choice="$2"
    local choice

    while true; do
        read -p "$prompt" choice
        if [[ "$choice" =~ ^[1-$max_choice]$ ]]; then
            echo "$choice"
            return
        else
            echo "Invalid choice. Please a number between 1 and $max_choice."
        fi
    done
}

protagonist() {
    echo "1.) Ask who they are."
    echo -e "2.) Run away as fast as possible.\n"
    choice=$(get_valid_input "Enter your choice (1-2): " 2)

    case $choice in
        1) who_are_they;;
        2) run_away;;
    esac
}

who_are_they() {
    newline
    echo -e "You ask  him, \"W-who are you?!\n"
    echo -e "You tremble, there is a certain presence in that old man that reverberates power... prestige.\n"
    echo -e "He says: \"I am Gecko the Firemaker. I heard about your recent job offer and I come to you with one better! Join me as my apprentice. You will learn wizardry, magic, dragonriding, and all the more! What say you, $USER?\n"
    echo "1) Join the wizard. When's something like this ever going to happen again?"
    echo -e "2) Politely decline. It might just be a crazy guy in a robe.\n"
    user_decision=$(get_valid_input "Enter your choice (1-2): " 2)

    if [[ $user_decision == "1" ]]; then
        newline
        echo -e "You hesitate, but give in... \"Fine. I'll join you on this endeavor, Gecko.\" You tell him.\n"
        echo "The wizard smiles, clicks his staff on the ground below, and POOF! You are transported to The Firesmith, a wizardry academy."
        wizard_offer
    else
        newline
        echo -e "You shake your head, disapprovingly. \"No thanks pops, but I refuse. I'm going to become a DevOps engineer!\n"
        echo "The wizard shrugs, clicks his staff to the ground and disappears."
        devops_offer
        newline
    fi
}

run_away() {
    newline
    echo -e "You run away, retracing your steps to the entrance of the hike, grab your car and drive home.\n"
    echo "As you drive, you keep shaking your head. You also can't shake the feeling that you've missed out on something wonderful. But what's done is done."
    echo "You arrive home, still thinking about the mysterious figure. Was it real or just your imagination?"
    echo "The end."
    newline
}

wizard_offer() {
    newline
    echo "Welcome to The Firesmith, $USER! Gecko leads you through Grand Mage Halls filled with floating books and shimmering portals. The place is a giant, like a hundred castles but as one."
    echo -e "\"Your training begins now,\" Gecko announces. \"Choose your first lesson:\"\n"
    echo "1) Elemental manipulation"
    echo -e "2) Dragonriding basics\n"
    lesson_choice=$(get_valid_input "Enter your choice (1-2): " 2)

    case $lesson_choice in
        1) elemental_magic ;;
        2) dragonriding ;;
    esac
}

elemental_magic() {
    newline
    echo "Gecko takes you to a chamber with swirling elements. \"Focus your mind and choose an element to bend to your will.\""
    echo "1) Fire"
    echo "2) Water"
    echo "3) Earth"
    echo -e "4) Air\n"
    element_choice=$(get_valid_input "Enter your choice (1-4): " 4)

    case $element_choice in
        1) echo "You imagine a great fire, burning bright. Then appears in your palm a speck of flame. Gecko gives a thumbs up only a dad would give his son." ;;
        2) echo "You imagine a river, endlessly flowing, tracing its journey to the ocean. Drops of water drizzle from your fingertips. Gecko claps enthusiastically." ;;
        3) echo "You imagine a rock, spinning in circles on a wide earthy platform. The earth around you moves. Gecko strokes his beard, impressed." ;;
        4) echo "You imagine Avatar Aang from The Last Airbender. A gentle breeze wafts over you and Gecko. Gecko chuckle and nods." ;;
    esac
    
    echo -e "\nGecko says to you: Well done, well done! You've taken your first step into the world of magic. Your journey as a wizard has just begun!"
}

dragonriding() {
    newline
    echo -e "Gecko walks with you to a vast field where several dragons are lounging. \"Choose your dragon,\" he says.\n"
    echo "1) Naar: the fire dragon"
    echo "2) Azulon: the ice dragon"
    echo -e "3) Steindaar: the gold-scaled dragon\n"
    dragon_choice=$(get_valid_input "Enter your choice (1-3): " 3)

    case $dragon_choice in
        1) echo "Naar, the fire dragon, roars a puff of smoke as you approach. You climb on, and he takes off with a fierce howl!" ;;
        2) echo "Azulon, the ice dragon, is quiet and reserved happily. You mount Azulon and she soars into the sky with incredible speed!" ;;
        3) echo "Steindaar gives a large roar before you hop on. He's known to be the most aggressive of all the three. He notices Gecko standing by, then bows its head as you near. You climb on gripping his shiny golden scales, and it gracefully lifts off!" ;;
    esac
    
    echo -e "\nAs you soar through the skies, you realize this is absolutely mindblowing. Who back home would ever believe this?! You're flying a dragon! This is just the beginning of your magical adventures."
}

devops_offer() {
    newline
    echo "You arrive at Amazon HQ for your first day as a DevOps engineer. Your manager greets you:"
    echo -e "\"Welcome, $USER! We have a critical project. Choose your first task:\"\n"
    echo "1) Optimize our CI/CD pipeline"
    echo -e "2) Implement a new monitoring system\n"
    devops_choice=$(get_valid_input "Enter your choice (1-2): " 2)

    case $devops_choice in
        1) cicd_pipeline ;;
        2) monitoring_system ;;
    esac
}

cicd_pipeline() {
    newline
    echo "You begin optimizing Amazon's CI/CD pipeline on the Customers service, streamlining processes and eliminating bottlenecks."
    echo "As you're deep in thought, your code editor starts to glow. 'What's happening?' You think to yourself. 'Am I getting hacked?' Then, the characters begin to rearrange themselves."
    echo "To your amazement, they form a message:"
    echo -e "\"Excellent work, $USER. You're not just coding, you're casting spells. Coding is magic, didn't you know that?\"\n"

    echo "You realize on your code editor as you scroll down, there is an ASCII art of a wizard hat. What the--?"
}

monitoring_system() {
    newline
    echo "You start implementing a new monitoring system with CloudWatch, as well as Prometheus and Grafana for some external services, setting up alerts and dashboards."
    echo "After some time passes by, you finish setting them up and feel great. Now things are being monitored for crashes, network and security issues, and the like."
    echo -e "You yawn and stretch as you close for the day. Looking over to the alert dashboard once more and notice something peculiar. Seeing the graph over the past 3 hours show a sudden spike in activity, your brow furrows. The pattern doesn't resemble any typical trend — instead, it almost looks like... text? Mysterious and seemingly random, the spikes seem to be forming some sort of message. You lean in closer, trying to make sense of it.\n"

    echo "As you look deeper, the text resembles these words: Perception is prone to the wizard soul."
}

protagonist