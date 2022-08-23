//
//  Constants.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 8/23/22.
//

import CoreGraphics

struct Constants {
    
    struct AnimalCell {
        static let MAIN_FONT_SIZE: CGFloat = 16
        static let SUB_FONT_SIZE: CGFloat = 9
        static let DISTANCE_FONT_SIZE: CGFloat = 12
    }
    
    struct Colors {
        static let DARK_GREY: String = "darkGrey"
        static let DIVIDER_GREY: String = "dividerGrey"
        static let LINK_PURPLE: String = "linkPurple"
        static let LOGO_TEXT_GREY: String = "logoTextGrey"
    }
    
    struct Fonts {
        static let OPEN_SANS: String = "Open Sans Bold"
        static let OPEN_SANS_SEMIBOLD: String = "Open Sans SemiBold"
        static let OPEN_SANS_BOLD: String = "Open Sans Bold"
    }
    
    struct Images {
        static let DOG_ICON: String = "Dog Icon.png"
        static let SHELTER_ICON : String = "Shelter Icon.png"
        static let APP_NAME_LOGO: String = "App Logo.png"
    }
    
    struct NavBar {
        static let NAV_BAR_FONT: String = "Cochin-Italic"
        static let NAV_BAR_FONT_SIZE: CGFloat = 30.0
        static let NAV_BAR_TITLE: String = "Save-A-Pup"
    }
    
    struct NetworkingConstants {
        static let animalApiUrl: String = "https://api.petfinder.com"
        static let apiTokenUrl: String = "https://api.petfinder.com/v2/oauth2/token"
        static let shelterApiUrl: String = "https://api.petfinder.com"
    }
    
    struct WelcomePage {
        static let TITLE_SUBTEXT: String = "Saving Animals."
        static let ANIMAL_TITLE: String = "Animals"
        static let BUTTON_TITLE_FONT: CGFloat = 16
        static let SHELTER_TITLE: String = "Shelters"
        static let SUBTITLE_FONT: CGFloat = 12
    }
}
