defmodule Assessment.Constants do
  import Assessment.Utils

  const(:militia, "Militia")
  const(:spearmen, "Spearmen")
  const(:light_cavalry, "LightCavalry")
  const(:heavy_cavalry, "HeavyCavalry")
  const(:cavalry_archer, "CavalryArcher")
  const(:foot_archer, "FootArcher")

  const(
    :error_input_e2,
    "Invalid input, provide input in form of '<platoon_name>#<no_of_platoons' 5 platoons each side"
  )

  const(:error_no_win, "There is no chance of winning")

  const(:joiint_banner, 
  "===============================================\n" <>
  "     # #######   ###     ###   #     # ####### \n" <>
  "     # #     #    #       #    ##    #    # \n" <>
  "     # #     #    #       #    # #   #    # \n" <>
  "     # #     #    #       #    #  #  #    # \n" <>
  "#    # #     #    #       #    #   # #    # \n" <>
  "#    # #     #    #       #    #    ##    # \n" <>
  "#####  #######   ###     ###   #     #    # \n" <>
  "===============================================\n")
end
