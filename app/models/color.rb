class Color < ApplicationRecord
  COLORS = [{ code: "#ffebee", name: "red lighten-5" },
            { code: "#ffcdd2", name: "red lighten-4" },
            { code: "#ef9a9a", name: "red lighten-3" },
            { code: "#e57373", name: "red lighten-2" },
            { code: "#ef5350", name: "red lighten-1" },
            { code: "#f44336", name: "red" },
            { code: "#e53935", name: "red darken-1" },
            { code: "#d32f2f", name: "red darken-2" },
            { code: "#c62828", name: "red darken-3" },
            { code: "#b71c1c", name: "red darken-4" },
            { code: "#ff8a80", name: "red accent-1" },
            { code: "#ff5252", name: "red accent-2" },
            { code: "#ff1744", name: "red accent-3" },
            { code: "#d50000", name: "red accent-4" },
            { code: "#fce4ec", name: "pink lighten-5" },
            { code: "#f8bbd0", name: "pink lighten-4" },
            { code: "#f48fb1", name: "pink lighten-3" },
            { code: "#f06292", name: "pink lighten-2" },
            { code: "#ec407a", name: "pink lighten-1" },
            { code: "#e91e63", name: "pink" },
            { code: "#d81b60", name: "pink darken-1" },
            { code: "#c2185b", name: "pink darken-2" },
            { code: "#ad1457", name: "pink darken-3" },
            { code: "#880e4f", name: "pink darken-4" },
            { code: "#ff80ab", name: "pink accent-1" },
            { code: "#ff4081", name: "pink accent-2" },
            { code: "#f50057", name: "pink accent-3" },
            { code: "#c51162", name: "pink accent-4" },
            { code: "#f3e5f5", name: "purple lighten-5" },
            { code: "#e1bee7", name: "purple lighten-4" },
            { code: "#ce93d8", name: "purple lighten-3" },
            { code: "#ba68c8", name: "purple lighten-2" },
            { code: "#ab47bc", name: "purple lighten-1" },
            { code: "#9c27b0", name: "purple" },
            { code: "#8e24aa", name: "purple darken-1" },
            { code: "#7b1fa2", name: "purple darken-2" },
            { code: "#6a1b9a", name: "purple darken-3" },
            { code: "#4a148c", name: "purple darken-4" },
            { code: "#ea80fc", name: "purple accent-1" },
            { code: "#e040fb", name: "purple accent-2" },
            { code: "#d500f9", name: "purple accent-3" },
            { code: "#aa00ff", name: "purple accent-4" },
            { code: "#ede7f6", name: "deep-purple lighten-5" },
            { code: "#d1c4e9", name: "deep-purple lighten-4" },
            { code: "#b39ddb", name: "deep-purple lighten-3" },
            { code: "#9575cd", name: "deep-purple lighten-2" },
            { code: "#7e57c2", name: "deep-purple lighten-1" },
            { code: "#673ab7", name: "deep-purple" },
            { code: "#5e35b1", name: "deep-purple darken-1" },
            { code: "#512da8", name: "deep-purple darken-2" },
            { code: "#4527a0", name: "deep-purple darken-3" },
            { code: "#311b92", name: "deep-purple darken-4" },
            { code: "#b388ff", name: "deep-purple accent-1" },
            { code: "#7c4dff", name: "deep-purple accent-2" },
            { code: "#651fff", name: "deep-purple accent-3" },
            { code: "#6200ea", name: "deep-purple accent-4" },
            { code: "#e8eaf6", name: "indigo lighten-5" },
            { code: "#c5cae9", name: "indigo lighten-4" },
            { code: "#9fa8da", name: "indigo lighten-3" },
            { code: "#7986cb", name: "indigo lighten-2" },
            { code: "#5c6bc0", name: "indigo lighten-1" },
            { code: "#3f51b5", name: "indigo" },
            { code: "#3949ab", name: "indigo darken-1" },
            { code: "#303f9f", name: "indigo darken-2" },
            { code: "#283593", name: "indigo darken-3" },
            { code: "#1a237e", name: "indigo darken-4" },
            { code: "#8c9eff", name: "indigo accent-1" },
            { code: "#536dfe", name: "indigo accent-2" },
            { code: "#3d5afe", name: "indigo accent-3" },
            { code: "#304ffe", name: "indigo accent-4" },
            { code: "#e3f2fd", name: "blue lighten-5" },
            { code: "#bbdefb", name: "blue lighten-4" },
            { code: "#90caf9", name: "blue lighten-3" },
            { code: "#64b5f6", name: "blue lighten-2" },
            { code: "#42a5f5", name: "blue lighten-1" },
            { code: "#2196f3", name: "blue" },
            { code: "#1e88e5", name: "blue darken-1" },
            { code: "#1976d2", name: "blue darken-2" },
            { code: "#1565c0", name: "blue darken-3" },
            { code: "#0d47a1", name: "blue darken-4" },
            { code: "#82b1ff", name: "blue accent-1" },
            { code: "#448aff", name: "blue accent-2" },
            { code: "#2979ff", name: "blue accent-3" },
            { code: "#2962ff", name: "blue accent-4" },
            { code: "#e1f5fe", name: "light-blue lighten-5" },
            { code: "#b3e5fc", name: "light-blue lighten-4" },
            { code: "#81d4fa", name: "light-blue lighten-3" },
            { code: "#4fc3f7", name: "light-blue lighten-2" },
            { code: "#29b6f6", name: "light-blue lighten-1" },
            { code: "#03a9f4", name: "light-blue" },
            { code: "#039be5", name: "light-blue darken-1" },
            { code: "#0288d1", name: "light-blue darken-2" },
            { code: "#0277bd", name: "light-blue darken-3" },
            { code: "#01579b", name: "light-blue darken-4" },
            { code: "#80d8ff", name: "light-blue accent-1" },
            { code: "#40c4ff", name: "light-blue accent-2" },
            { code: "#00b0ff", name: "light-blue accent-3" },
            { code: "#0091ea", name: "light-blue accent-4" },
            { code: "#e0f7fa", name: "cyan lighten-5" },
            { code: "#b2ebf2", name: "cyan lighten-4" },
            { code: "#80deea", name: "cyan lighten-3" },
            { code: "#4dd0e1", name: "cyan lighten-2" },
            { code: "#26c6da", name: "cyan lighten-1" },
            { code: "#00bcd4", name: "cyan" },
            { code: "#00acc1", name: "cyan darken-1" },
            { code: "#0097a7", name: "cyan darken-2" },
            { code: "#00838f", name: "cyan darken-3" },
            { code: "#006064", name: "cyan darken-4" },
            { code: "#84ffff", name: "cyan accent-1" },
            { code: "#18ffff", name: "cyan accent-2" },
            { code: "#00e5ff", name: "cyan accent-3" },
            { code: "#00b8d4", name: "cyan accent-4" },
            { code: "#e0f2f1", name: "teal lighten-5" },
            { code: "#b2dfdb", name: "teal lighten-4" },
            { code: "#80cbc4", name: "teal lighten-3" },
            { code: "#4db6ac", name: "teal lighten-2" },
            { code: "#26a69a", name: "teal lighten-1" },
            { code: "#009688", name: "teal" },
            { code: "#00897b", name: "teal darken-1" },
            { code: "#00796b", name: "teal darken-2" },
            { code: "#00695c", name: "teal darken-3" },
            { code: "#004d40", name: "teal darken-4" },
            { code: "#a7ffeb", name: "teal accent-1" },
            { code: "#64ffda", name: "teal accent-2" },
            { code: "#1de9b6", name: "teal accent-3" },
            { code: "#00bfa5", name: "teal accent-4" },
            { code: "#e8f5e9", name: "green lighten-5" },
            { code: "#c8e6c9", name: "green lighten-4" },
            { code: "#a5d6a7", name: "green lighten-3" },
            { code: "#81c784", name: "green lighten-2" },
            { code: "#66bb6a", name: "green lighten-1" },
            { code: "#4caf50", name: "green" },
            { code: "#43a047", name: "green darken-1" },
            { code: "#388e3c", name: "green darken-2" },
            { code: "#2e7d32", name: "green darken-3" },
            { code: "#1b5e20", name: "green darken-4" },
            { code: "#b9f6ca", name: "green accent-1" },
            { code: "#69f0ae", name: "green accent-2" },
            { code: "#00e676", name: "green accent-3" },
            { code: "#00c853", name: "green accent-4" },
            { code: "#f1f8e9", name: "light-green lighten-5" },
            { code: "#dcedc8", name: "light-green lighten-4" },
            { code: "#c5e1a5", name: "light-green lighten-3" },
            { code: "#aed581", name: "light-green lighten-2" },
            { code: "#9ccc65", name: "light-green lighten-1" },
            { code: "#8bc34a", name: "light-green" },
            { code: "#7cb342", name: "light-green darken-1" },
            { code: "#689f38", name: "light-green darken-2" },
            { code: "#558b2f", name: "light-green darken-3" },
            { code: "#33691e", name: "light-green darken-4" },
            { code: "#ccff90", name: "light-green accent-1" },
            { code: "#b2ff59", name: "light-green accent-2" },
            { code: "#76ff03", name: "light-green accent-3" },
            { code: "#64dd17", name: "light-green accent-4" },
            { code: "#f9fbe7", name: "lime lighten-5" },
            { code: "#f0f4c3", name: "lime lighten-4" },
            { code: "#e6ee9c", name: "lime lighten-3" },
            { code: "#dce775", name: "lime lighten-2" },
            { code: "#d4e157", name: "lime lighten-1" },
            { code: "#cddc39", name: "lime" },
            { code: "#c0ca33", name: "lime darken-1" },
            { code: "#afb42b", name: "lime darken-2" },
            { code: "#9e9d24", name: "lime darken-3" },
            { code: "#827717", name: "lime darken-4" },
            { code: "#f4ff81", name: "lime accent-1" },
            { code: "#eeff41", name: "lime accent-2" },
            { code: "#c6ff00", name: "lime accent-3" },
            { code: "#aeea00", name: "lime accent-4" },
            { code: "#fffde7", name: "yellow lighten-5" },
            { code: "#fff9c4", name: "yellow lighten-4" },
            { code: "#fff59d", name: "yellow lighten-3" },
            { code: "#fff176", name: "yellow lighten-2" },
            { code: "#ffee58", name: "yellow lighten-1" },
            { code: "#ffeb3b", name: "yellow" },
            { code: "#fdd835", name: "yellow darken-1" },
            { code: "#fbc02d", name: "yellow darken-2" },
            { code: "#f9a825", name: "yellow darken-3" },
            { code: "#f57f17", name: "yellow darken-4" },
            { code: "#ffff8d", name: "yellow accent-1" },
            { code: "#ffff00", name: "yellow accent-2" },
            { code: "#ffea00", name: "yellow accent-3" },
            { code: "#ffd600", name: "yellow accent-4" },
            { code: "#fff8e1", name: "amber lighten-5" },
            { code: "#ffecb3", name: "amber lighten-4" },
            { code: "#ffe082", name: "amber lighten-3" },
            { code: "#ffd54f", name: "amber lighten-2" },
            { code: "#ffca28", name: "amber lighten-1" },
            { code: "#ffc107", name: "amber" },
            { code: "#ffb300", name: "amber darken-1" },
            { code: "#ffa000", name: "amber darken-2" },
            { code: "#ff8f00", name: "amber darken-3" },
            { code: "#ff6f00", name: "amber darken-4" },
            { code: "#ffe57f", name: "amber accent-1" },
            { code: "#ffd740", name: "amber accent-2" },
            { code: "#ffc400", name: "amber accent-3" },
            { code: "#ffab00", name: "amber accent-4" },
            { code: "#fff3e0", name: "orange lighten-5" },
            { code: "#ffe0b2", name: "orange lighten-4" },
            { code: "#ffcc80", name: "orange lighten-3" },
            { code: "#ffb74d", name: "orange lighten-2" },
            { code: "#ffa726", name: "orange lighten-1" },
            { code: "#ff9800", name: "orange" },
            { code: "#fb8c00", name: "orange darken-1" },
            { code: "#f57c00", name: "orange darken-2" },
            { code: "#ef6c00", name: "orange darken-3" },
            { code: "#e65100", name: "orange darken-4" },
            { code: "#ffd180", name: "orange accent-1" },
            { code: "#ffab40", name: "orange accent-2" },
            { code: "#ff9100", name: "orange accent-3" },
            { code: "#ff6d00", name: "orange accent-4" },
            { code: "#fbe9e7", name: "deep-orange lighten-5" },
            { code: "#ffccbc", name: "deep-orange lighten-4" },
            { code: "#ffab91", name: "deep-orange lighten-3" },
            { code: "#ff8a65", name: "deep-orange lighten-2" },
            { code: "#ff7043", name: "deep-orange lighten-1" },
            { code: "#ff5722", name: "deep-orange" },
            { code: "#f4511e", name: "deep-orange darken-1" },
            { code: "#e64a19", name: "deep-orange darken-2" },
            { code: "#d84315", name: "deep-orange darken-3" },
            { code: "#bf360c", name: "deep-orange darken-4" },
            { code: "#ff9e80", name: "deep-orange accent-1" },
            { code: "#ff6e40", name: "deep-orange accent-2" },
            { code: "#ff3d00", name: "deep-orange accent-3" },
            { code: "#dd2c00", name: "deep-orange accent-4" },
            { code: "#efebe9", name: "brown lighten-5" },
            { code: "#d7ccc8", name: "brown lighten-4" },
            { code: "#bcaaa4", name: "brown lighten-3" },
            { code: "#a1887f", name: "brown lighten-2" },
            { code: "#8d6e63", name: "brown lighten-1" },
            { code: "#795548", name: "brown" },
            { code: "#6d4c41", name: "brown darken-1" },
            { code: "#5d4037", name: "brown darken-2" },
            { code: "#4e342e", name: "brown darken-3" },
            { code: "#3e2723", name: "brown darken-4" },
            { code: "#fafafa", name: "grey lighten-5" },
            { code: "#f5f5f5", name: "grey lighten-4" },
            { code: "#eeeeee", name: "grey lighten-3" },
            { code: "#e0e0e0", name: "grey lighten-2" },
            { code: "#bdbdbd", name: "grey lighten-1" },
            { code: "#9e9e9e", name: "grey" },
            { code: "#757575", name: "grey darken-1" },
            { code: "#616161", name: "grey darken-2" },
            { code: "#424242", name: "grey darken-3" },
            { code: "#212121", name: "grey darken-4" },
            { code: "#eceff1", name: "blue-grey lighten-5" },
            { code: "#cfd8dc", name: "blue-grey lighten-4" },
            { code: "#b0bec5", name: "blue-grey lighten-3" },
            { code: "#90a4ae", name: "blue-grey lighten-2" },
            { code: "#78909c", name: "blue-grey lighten-1" },
            { code: "#607d8b", name: "blue-grey" },
            { code: "#546e7a", name: "blue-grey darken-1" },
            { code: "#455a64", name: "blue-grey darken-2" },
            { code: "#37474f", name: "blue-grey darken-3" },
            { code: "#263238", name: "blue-grey darken-4" },
            { code: "#000000", name: "black" },
            { code: "#ffffff", name: "white" } ]


  def self.seed!
    delete_all
    COLORS.each do |color|
      create(name: color[:name], code: color[:code])
    end
  end
end