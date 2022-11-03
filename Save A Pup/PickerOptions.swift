//
//  PickerOptions.swift
//  Save A Pup
//
//  Created by Neal Siegrist on 10/27/22.
//

import Foundation

struct PickerOptions {
    
    //sorted
    static private let dogBreeds: [String] = ["All", "Affenpinscher", "Afghan Hound", "Airedale Terrier", "Akbash", "Akita", "Alaskan Malamute", "American Bulldog", "American Bully", "American Eskimo Dog", "American Foxhound", "American Hairless Terrier", "American Staffordshire Terrier", "American Water Spaniel", "Anatolian Shepherd", "Appenzell Mountain Dog", "Aussiedoodle", "Australian Cattle Dog / Blue Heeler", "Australian Kelpie", "Australian Shepherd", "Australian Terrier", "Basenji", "Basset Hound", "Beagle", "Bearded Collie", "Beauceron", "Bedlington Terrier", "Belgian Shepherd / Laekenois", "Belgian Shepherd / Malinois", "Belgian Shepherd / Sheepdog", "Belgian Shepherd / Tervuren", "Bernedoodle", "Bernese Mountain Dog", "Bichon Frise", "Black Labrador Retriever", "Black Mouth Cur", "Black Russian Terrier", "Black and Tan Coonhound", "Bloodhound", "Blue Lacy", "Bluetick Coonhound", "Boerboel", "Bolognese", "Border Collie", "Border Terrier", "Borzoi", "Boston Terrier", "Bouvier des Flandres", "Boxer", "Boykin Spaniel", "Briard", "Brittany Spaniel", "Brussels Griffon", "Bull Terrier", "Bullmastiff", "Cairn Terrier", "Canaan Dog", "Cane Corso", "Cardigan Welsh Corgi", "Carolina Dog", "Catahoula Leopard Dog", "Cattle Dog", "Caucasian Sheepdog / Caucasian Ovtcharka", "Cavachon", "Cavalier King Charles Spaniel", "Cavapoo", "Chesapeake Bay Retriever", "Chihuahua", "Chinese Crested Dog", "Chinese Foo Dog", "Chinook", "Chiweenie", "Chocolate Labrador Retriever", "Chow Chow", "Cirneco dell\'Etna", "Clumber Spaniel", "Cockapoo", "Cocker Spaniel", "Collie", "Coonhound", "Corgi", "Coton de Tulear", "Curly-Coated Retriever", "Dachshund", "Dalmatian", "Dandie Dinmont Terrier", "Doberman Pinscher", "Dogo Argentino", "Dogue de Bordeaux", "Dutch Shepherd", "English Bulldog", "English Cocker Spaniel", "English Coonhound", "English Foxhound", "English Pointer", "English Setter", "English Shepherd", "English Springer Spaniel", "English Toy Spaniel", "Entlebucher", "Eskimo Dog", "Feist", "Field Spaniel", "Fila Brasileiro", "Finnish Lapphund", "Finnish Spitz", "Flat-Coated Retriever", "Fox Terrier", "Foxhound", "French Bulldog", "Galgo Spanish Greyhound", "German Pinscher", "German Shepherd Dog", "German Shorthaired Pointer", "German Spitz", "German Wirehaired Pointer", "Giant Schnauzer", "Glen of Imaal Terrier", "Golden Retriever", "Goldendoodle", "Gordon Setter", "Great Dane", "Great Pyrenees", "Greater Swiss Mountain Dog", "Greyhound", "Hamiltonstovare", "Harrier", "Havanese", "Hound", "Hovawart", "Husky", "Ibizan Hound", "Icelandic Sheepdog", "Illyrian Sheepdog", "Irish Setter", "Irish Terrier", "Irish Water Spaniel", "Irish Wolfhound", "Italian Greyhound", "Jack Russell Terrier", "Japanese Chin", "Jindo", "Kai Dog", "Karelian Bear Dog", "Keeshond", "Kerry Blue Terrier", "Kishu", "Klee Kai", "Komondor", "Kuvasz", "Kyi Leo", "Labradoodle", "Labrador Retriever", "Lakeland Terrier", "Lancashire Heeler", "Leonberger", "Lhasa Apso", "Lowchen", "Lurcher", "Maltese", "Maltipoo", "Manchester Terrier", "Maremma Sheepdog", "Mastiff", "McNab", "Miniature Bull Terrier", "Miniature Dachshund", "Miniature Pinscher", "Miniature Poodle", "Miniature Schnauzer", "Mixed Breed", "Morkie", "Mountain Cur", "Mountain Dog", "Munsterlander", "Neapolitan Mastiff", "New Guinea Singing Dog", "Newfoundland Dog", "Norfolk Terrier", "Norwegian Buhund", "Norwegian Elkhound", "Norwegian Lundehund", "Norwich Terrier", "Nova Scotia Duck Tolling Retriever", "Old English Sheepdog", "Otterhound", "Papillon", "Parson Russell Terrier", "Patterdale Terrier / Fell Terrier", "Pekingese", "Pembroke Welsh Corgi", "Peruvian Inca Orchid", "Petit Basset Griffon Vendeen", "Pharaoh Hound", "Pit Bull Terrier", "Plott Hound", "Pointer", "Polish Lowland Sheepdog", "Pomeranian", "Pomsky", "Poodle", "Portuguese Podengo", "Portuguese Water Dog", "Presa Canario", "Pug", "Puggle", "Puli", "Pumi", "Pyrenean Shepherd", "Rat Terrier", "Redbone Coonhound", "Retriever", "Rhodesian Ridgeback", "Rottweiler", "Rough Collie", "Saint Bernard", "Saluki", "Samoyed", "Sarplaninac", "Schipperke", "Schnauzer", "Schnoodle", "Scottish Deerhound", "Scottish Terrier", "Sealyham Terrier", "Setter", "Shar-Pei", "Sheep Dog", "Sheepadoodle", "Shepherd", "Shetland Sheepdog / Sheltie", "Shiba Inu", "Shih Tzu", "Shih poo", "Shollie", "Siberian Husky", "Silky Terrier", "Skye Terrier", "Sloughi", "Smooth Collie", "Smooth Fox Terrier", "South Russian Ovtcharka", "Spaniel", "Spanish Water Dog", "Spinone Italiano", "Spitz", "Staffordshire Bull Terrier", "Standard Poodle", "Standard Schnauzer", "Sussex Spaniel", "Swedish Vallhund", "Tennessee Treeing Brindle", "Terrier", "Thai Ridgeback", "Tibetan Mastiff", "Tibetan Spaniel", "Tibetan Terrier", "Tosa Inu", "Toy Fox Terrier", "Toy Manchester Terrier", "Treeing Walker Coonhound", "Vizsla", "Weimaraner", "Welsh Springer Spaniel", "Welsh Terrier", "West Highland White Terrier / Westie", "Wheaten Terrier", "Whippet", "White German Shepherd", "Wire Fox Terrier", "Wirehaired Dachshund", "Wirehaired Pointing Griffon", "Wirehaired Terrier", "Xoloitzcuintli / Mexican Hairless", "Yellow Labrador Retriever", "Yorkshire Terrier"]
    
    static private let catBreeds: [String] = ["All", "Abyssinian", "American Bobtail", "American Curl", "American Shorthair", "American Wirehair", "Applehead Siamese", "Balinese", "Bengal", "Birman", "Bombay", "British Shorthair", "Burmese", "Burmilla", "Calico", "Canadian Hairless", "Chartreux", "Chausie", "Chinchilla", "Cornish Rex", "Cymric", "Devon Rex", "Dilute Calico", "Dilute Tortoiseshell", "Domestic Long Hair", "Domestic Medium Hair", "Domestic Short Hair", "Egyptian Mau", "Exotic Shorthair", "Extra-Toes Cat / Hemingway Polydactyl", "Havana", "Himalayan", "Japanese Bobtail", "Javanese", "Korat", "LaPerm", "Maine Coon", "Manx", "Munchkin", "Nebelung", "Norwegian Forest Cat", "Ocicat", "Oriental Long Hair", "Oriental Short Hair", "Oriental Tabby", "Persian", "Pixiebob", "Ragamuffin", "Ragdoll", "Russian Blue", "Scottish Fold", "Selkirk Rex", "Siamese", "Siberian", "Silver", "Singapura", "Snowshoe", "Somali", "Sphynx / Hairless Cat", "Tabby", "Tiger", "Tonkinese", "Torbie", "Tortoiseshell", "Toyger", "Turkish Angora", "Turkish Van", "Tuxedo", "York Chocolate"]
    
    static private let rabbitBreeds: [String] = ["All", "American", "American Fuzzy Lop", "American Sable", "Angora Rabbit", "Belgian Hare", "Beveren", "Britannia Petite", "Bunny Rabbit", "Californian", "Champagne D\'Argent", "Checkered Giant", "Chinchilla", "Cinnamon", "Creme D\'Argent", "Dutch", "Dwarf", "Dwarf Eared", "English Lop", "English Spot", "Flemish Giant", "Florida White", "French Lop", "Harlequin", "Havana", "Himalayan", "Holland Lop", "Hotot", "Jersey Wooly", "Lilac", "Lionhead", "Lop Eared", "Mini Lop", "Mini Rex", "Netherland Dwarf", "New Zealand", "Palomino", "Polish", "Rex", "Rhinelander", "Satin", "Silver", "Silver Fox", "Silver Marten", "Tan"]
    
    static private let smallFurryBreeds: [String] = ["All", "Abyssinian", "Chinchilla", "Degu", "Dwarf Hamster", "Ferret", "Gerbil", "Guinea Pig", "Hamster", "Hedgehog", "Mouse", "Peruvian", "Prairie Dog", "Rat", "Rex", "Short-Haired", "Silkie / Sheltie", "Skunk", "Sugar Glider", "Teddy"]
    
    static private let horseBreeds: [String] = ["All", "Appaloosa", "Arabian", "Belgian", "Clydesdale", "Connemara", "Curly Horse", "Donkey", "Draft", "Friesian", "Gaited", "Grade", "Haflinger", "Icelandic Horse", "Lipizzan", "Miniature Horse", "Missouri Foxtrotter", "Morgan", "Mule", "Mustang", "Paint / Pinto", "Palomino", "Paso Fino", "Percheron", "Peruvian Paso", "Pony", "Pony of the Americas", "Quarterhorse", "Rocky Mountain Horse", "Saddlebred", "Shetland Pony", "Standardbred", "Tennessee Walker", "Thoroughbred", "Warmblood"]
    
    static private let birdBreeds: [String] = ["All", "African Grey", "Amazon", "Brotogeris", "Budgie / Budgerigar", "Button-Quail", "Caique", "Canary", "Chicken", "Cockatiel", "Cockatoo", "Conure", "Dove", "Duck", "Eclectus", "Emu", "Finch", "Goose", "Guinea Fowl", "Kakariki", "Lory / Lorikeet", "Lovebird", "Macaw", "Ostrich", "Parakeet (Other)", "Parrot (Other)", "Parrotlet", "Peacock / Peafowl", "Pheasant", "Pigeon", "Pionus", "Poicephalus / Senegal", "Quail", "Quaker Parakeet", "Rhea", "Ringneck / Psittacula", "Rosella", "Swan", "Toucan", "Turkey"]
    
    static private let scalesFinsBreeds: [String] = ["All", "Asian Box", "Ball Python", "Bearded Dragon", "Boa", "Boa Constrictor", "Box", "Bull", "Bullfrog", "Burmese Python", "Chameleon", "Corn / Rat", "Eastern Box", "Fire Salamander", "Fire-Bellied", "Fire-Bellied Newt", "Florida Box", "Freshwater Fish", "Frog", "Garter / Ribbon", "Gecko", "Goldfish", "Hermit Crab", "Horned Frog", "Iguana", "King / Milk", "Leopard", "Leopard Frog", "Lizard", "Mississippi Map Turtle", "Monitor", "Mud", "Musk", "Oregon Newt", "Ornamental Box", "Other", "Paddle Tailed Newt", "Painted", "Python", "Red Foot", "Red-Eared Slider", "Russian", "Saltwater Fish", "Scorpion", "Snake", "Snapping", "Soft Shell", "Southern", "Sulcata", "Tarantula", "Three-Toed Box", "Tiger Salamander", "Toad", "Tortoise", "Tree Frog", "Turtle", "Uromastyx", "Water Dragon", "Yellow-Bellied Slider"]
    
    static private let barnyardBreeds: [String] = ["All", "Alpaca", "Alpine", "Angora", "Angus", "Barbados", "Boer", "Cow", "Duroc", "Goat", "Hampshire", "Holstein", "Jersey", "LaMancha", "Landrace", "Llama", "Merino", "Mouflon", "Myotonic / Fainting", "Nigerian Dwarf", "Nubian", "Oberhasli", "Pig", "Pot Bellied", "Pygmy", "Saanen", "Sheep", "Shetland", "Toggenburg", "Vietnamese Pot Bellied", "Yorkshire"]
    
    static private let animalTypes: [String: [String]] = ["Dog": dogBreeds, "Cat": catBreeds, "Rabbit":rabbitBreeds, "Small & Furry": smallFurryBreeds, "Horse":horseBreeds, "Bird":birdBreeds, "Scales, Fins & Other": scalesFinsBreeds, "Barnyard": barnyardBreeds]
    
    static private let animalCoats: [String: [String]] = ["Dog": ["Hairless", "Short", "Medium", "Long", "Wire", "Curly"], "Cat": ["Hairless", "Short", "Medium", "Long"], "Rabbit":["Short", "Long"], "Small & Furry": ["Hairless", "Short", "Long"], "Horse":[], "Bird":[], "Scales, Fins & Other": [], "Barnyard": ["Short", "Long"]]
   
    static private let animalColors: [String: [String]] = ["Dog": ["Apricot / Beige", "Bicolor", "Black", "Brindle", "Brown / Chocolate", "Golden", "Gray / Blue / Silver", "Harlequin", "Merle (Blue)", "Merle (Red)", "Red / Chestnut / Orange", "Sable", "White / Cream", "Yellow / Tan / Blond / Fawn"], "Cat": ["Black", "Black & White / Tuxedo", "Blue Cream", "Blue Point", "Brown / Chocolate", "Buff & White", "Buff / Tan / Fawn", "Calico", "Chocolate Point", "Cream / Ivory", "Cream Point", "Dilute Calico", "Dilute Tortoiseshell", "Flame Point", "Gray & White", "Gray / Blue / Silver", "Lilac Point", "Orange & White", "Orange / Red", "Seal Point",
        "Smoke", "Tabby (Brown / Chocolate)", "Tabby (Buff / Tan / Fawn)", "Tabby (Gray / Blue / Silver)", "Tabby (Leopard / Spotted)", "Tabby (Orange / Red)",
        "Tabby (Tiger Striped)", "Torbie", "Tortoiseshell", "White"], "Rabbit":["Agouti", "Black", "Blue / Gray", "Brown / Chocolate", "Cream", "Lilac", "Orange / Red", "Sable", "Silver Marten", "Tan", "Tortoiseshell", "White"], "Small & Furry": ["Agouti", "Albino", "Black", "Black Sable", "Blue / Gray", "Brown / Chocolate", "Calico", "Champagne", "Cinnamon", "Cream", "Orange / Red", "Sable", "Tan", "Tortoiseshell", "White", "White (Dark-Eyed)"], "Horse":["Appaloosa", "Bay", "Bay Roan", "Black", "Blue Roan", "Brown", "Buckskin", "Champagne", "Chestnut / Sorrel", "Cremello", "Dapple Gray", "Dun", "Gray", "Grullo", "Liver", "Paint", "Palomino", "Perlino", "Piebald", "Pinto", "Red Roan", "Silver Bay", "Silver Buckskin", "Silver Dapple", "White"], "Bird":["Black", "Blue", "Brown", "Buff", "Gray", "Green", "Olive", "Orange", "Pink", "Purple / Violet", "Red", "Rust / Rufous", "Tan", "White", "Yellow"], "Scales, Fins & Other": ["Black", "Blue", "Brown", "Gray", "Green", "Iridescent", "Orange", "Purple", "Red", "Tan", "White", "Yellow"], "Barnyard": ["Agouti", "Black", "Black & White", "Brindle", "Brown", "Gray", "Pink", "Red", "Roan", "Spotted", "Tan", "White"]]
    
    static private let animalGenders: [String: [String]] = ["Dog": ["All", "Female", "Male"], "Cat": ["All", "Female", "Male"], "Rabbit":["All", "Female", "Male"], "Small & Furry": ["All", "Female", "Male"], "Horse":["All", "Female", "Male"], "Bird": ["All", "Female", "Male", "Unknown"], "Scales, Fins & Other": ["All", "Female", "Male", "Unknown"], "Barnyard": ["All", "Female", "Male"]]
    
    static private let sizes: [String] = ["All", "small", "medium", "large", "xlarge"]
    
    static private let ages: [String] = ["All", "baby", "young", "adult", "senior"]
    
    static private let status: [String] = ["All", "adoptable", "adopted", "found"]
    
    //MARK: - Functions
    
    static func getStatus() -> [String] {
        return status
    }
    
    static func getSizes() -> [String] {
        return sizes
    }
    
    static func getAges() -> [String] {
        return ages
    }
    
    static func getAnimalTypes() -> [String]? {
        var keys: [String] = []

        for key in animalTypes.keys {
            keys.append(key)
        }
        
        if !keys.isEmpty {
            keys.insert("All", at: 0)
        }
        
        keys.sort()
        
        return keys
    }
    
    static func getGenders(animalType: String) -> [String]? {
        return animalGenders[animalType]
    }
    
    static func getBreeds(animalType: String) -> [String]? {
        return animalTypes[animalType]
    }
    
    static func getCoats(animalType: String) -> [String]? {
        guard var coats = animalCoats[animalType] else {
            print("no coats")
            return nil
        }
        
        coats.sort()
        
        if !coats.isEmpty {
            coats.insert("All", at: 0)
        }
        
        
        
        return coats
    }
    
    static func getColors(animalType: String) -> [String]? {
        guard var colors = animalColors[animalType] else {
            print("no colors")
            return nil
        }
        
        colors.sort()
        
        if !colors.isEmpty {
            colors.insert("All", at: 0)
        }
        
        return colors
    }
}
