package main
// declares package name. 
// The "main" package is special in Go; it's where execution begins

// fmt stands for format; imports the format package
import (
	//"log"
	"fmt"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
)

// main() is the entry point of the app
func main() {
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: Provider,
	})
	// Format.PrintLine
	// prints to standard output
    fmt.Println("Hello, World!")
}

// in golang, a title case function will get exported
func Provider() *schema.Provider {
	var p *schema.Provider
	p = &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{

		},
		DataSourcesMap: map[string]*schema.Resource{
			
		},
		Schema: map[string]*schema.Schema{
			"endpoint": {
				Type: schema.TypeString,
				Required: true,
				Description: "The endpoint for the external service",
			},
			"token": {
				Type: schema.TypeString,
				Sensitive: true, // mark the token as sensitive to hide it in logs
				Required: true,
				Description: "Bearer token for authorization",
			},
			"user_uuid": {
				Type: schema.TypeString,
				Required: true,
				Description: "UUID for configuration",
				//ValidateFunc: validateUUID,
			},
		},
	}
	//p.ConfigureContextFunc = providerConfigure(p)
	return p
}

// func validateUUID(v interface{}, k string) (ws []string, errors []error) {
// 	log.Print('validateUUID:start')
// 	value := v.(string)
// 	if _,err = uuid.Parse(value); err != nil {
// 		errors = append(error,fmt.Errorf("invalid UUID format"))
// 	}
// 	log.Print('validateUUID:end')
// }