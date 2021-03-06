describe "Basic slider", ->
  sliderContainer = undefined
  beforeEach ->
    sliderContainer = $("<ul class=\"slider\"><li>1</li><li>2</li><li>3</li></ul>").appendTo($("body")).slider()

  afterEach ->
    sliderContainer.remove()
    $(".slider-control").remove()

  describe "Controls should exist and work as expected", ->
    it "should have a previous control", ->
      expect($(".slider-prev")).toExist()

    it "should have a next control", ->
      expect($(".slider-next")).toExist()

    it "should have 2 item controls", ->
      expect($(".slider-goto").length).toBe 3

    it "should start on the first slide", ->
      expect(sliderContainer).toHaveData "position", 0

    it "should advance when next is clicked", ->
      $(".slider-next").click()
      expect(sliderContainer).toHaveData "position", 1

    it "should not advance past the end", ->
      $(".slider-next").click()
      $(".slider-next").click()
      $(".slider-next").click()
      expect(sliderContainer).toHaveData "position", 2

    it "should go back when prev is clicked", ->
      $(".slider-next").click()
      $(".slider-prev").click()
      expect(sliderContainer).toHaveData "position", 0

    it "should not go back past the start", ->
      $(".slider-prev").click()
      $(".slider-prev").click()
      expect(sliderContainer).toHaveData "position", 0

    it "should go to a specific item", ->
      $(".slider-goto-1").click()
      expect(sliderContainer).toHaveData "position", 1
      $(".slider-goto-0").click()
      expect(sliderContainer).toHaveData "position", 0

  describe "Next and previous controls should indicate when they are disabled", ->
    it "should set disabled class on the next button when the end is reached", ->
      $(".slider-next").click()
      $(".slider-next").click()
      expect($(".slider-next")).toBeDisabled()

    it "should set disabled class on the previous button when the start is reached", ->
      $(".slider-next").click()
      $(".slider-prev").click()
      expect($(".slider-prev")).toBeDisabled()

    it "should set disabled class on the previous button initially", ->
      expect($(".slider-prev")).toBeDisabled()

    it "should remove disabled class from the previous button when first position is left", ->
      $(".slider-next").click()
      expect($(".slider-prev")).not.toBeDisabled()

    it "should remove disabled class from the next button when the last position is left", ->
      $(".slider-next").click()
      $(".slider-next").click()
      $(".slider-prev").click()
      expect($(".slider-next")).not.toBeDisabled()

  describe "Controls should have sensible default labels", ->
    it "should have a sensible default label for the previous button", ->
      expect($(".slider-prev")).toHaveText "previous"

    it "should have a sensible default label for the next button", ->
      expect($(".slider-next")).toHaveText "next"

    it "should have numeric labels for item buttons", ->
      expect($(".slider-goto-0")).toHaveText "0"
      expect($(".slider-goto-1")).toHaveText "1"
      expect($(".slider-goto-2")).toHaveText "2"

  describe "Controls should set the slider-active class on active items", ->
    it "should set the slider-active class on the first item initially", ->
      pos = sliderContainer.data("position")
      expect(sliderContainer.find("li").first()).toHaveClass "slider-active"

    it "should set the slider-active class on the first item initially", ->
      $(".slider-next").click()
      pos = sliderContainer.data("position")
      expect($(sliderContainer.find("li").get(pos))).toHaveClass "slider-active"