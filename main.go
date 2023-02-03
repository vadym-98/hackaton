package main

import (
	"fmt"
	"github.com/gofiber/fiber/v2"
	"log"
	"net/http"
)

const (
	Host = "172.31.20.109"
	Port = "8080"
)

type Response struct {
	Status  int    `json:"status"`
	Message string `json:"message"`
}

func main() {
	app := fiber.New()
	app.Get("/", func(ctx *fiber.Ctx) error {
		return ctx.Status(http.StatusOK).JSON(&Response{
			Status:  http.StatusOK,
			Message: "home route",
		})
	})

	app.Get("/healthz", func(ctx *fiber.Ctx) error {
		return ctx.Status(http.StatusOK).JSON(&Response{
			Status:  http.StatusOK,
			Message: "healthz route",
		})
	})

	log.Fatal(app.Listen(fmt.Sprintf("%s:%s", Host, Port)))
}
