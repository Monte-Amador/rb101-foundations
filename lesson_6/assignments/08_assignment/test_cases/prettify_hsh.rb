hsh = {
  dealer: [],
  player: [],
  suits: { 
    hearts: {
      ace: [1, 11], 
      jack: 10, 
      queen: 10, 
      king: 10, 
      numerical: [2, 3, 4, 5, 6, 7, 8, 9, 10]
    },
    diamonds: {
      ace: [1, 11], 
      jack: 10, 
      queen: 10, 
      king: 10, 
      numerical: [2, 3, 4, 5, 6, 7, 8, 9, 10]
    },
    clubs: {
      ace: [1, 11], 
      jack: 10, 
      queen: 10, 
      king: 10, 
      numerical: [2, 3, 4, 5, 6, 7, 8, 9, 10]
    },
    spades: {
      ace: [1, 11], 
      jack: 10, 
      queen: 10, 
      king: 10, 
      numerical: [2, 3, 4, 5, 6, 7, 8, 9, 10]
    },
  }
}
puts hsh[:suits][:spades][:ace].sample
