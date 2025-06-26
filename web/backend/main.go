package main

import (
	"fmt"
	"math/rand"

	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
)

func main() {
	app := fiber.New()

	app.Use(cors.New(cors.Config{
		AllowOrigins: "*", // or "https://frontend.serhatsari.dev"
		AllowMethods: "GET,OPTIONS",
	}))

	app.Get("/api/", func(c *fiber.Ctx) error {
		// Simulate some processing time
		for i := 0; i < 1e7; i++ {
			_ = i * i
		}

		randomNumber := rand.Intn(1000) // 0-999

		message := fmt.Sprintf("Merhaba Enuygun... Random bi sayi: %d", randomNumber)

		return c.JSON(fiber.Map{
			"message": message,
		})
	})

	// Health check endpoint
	app.Get("/api/health", func(c *fiber.Ctx) error {
		return c.JSON(fiber.Map{
			"status": "ok",
		})
	})

	if err := app.Listen(":3000"); err != nil {
		panic(err)
	}
}
