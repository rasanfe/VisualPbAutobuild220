using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using IdentityModel;
using Microsoft.Extensions.Logging;

namespace ServerAPIs
{
    public class DefaultUserStore : IUserStore
    {
        private readonly ILogger _logger;
        private readonly List<UserModel> _users;

        public DefaultUserStore(ILogger<DefaultUserStore> logger)
        {
            _logger = logger;

            _users = new List<UserModel>
            {
                new UserModel
                {
                     Username = "UserName",
                    Password = "UserPass" ,
                    Claims = new[]
                    {
                        // Claims the "serverapi" scope
                        new Claim(JwtClaimTypes.Scope, "Scope"),
                        new Claim(JwtClaimTypes.Name, "Name"),
                        new Claim(JwtClaimTypes.GivenName, "GivenName"),
                        new Claim(JwtClaimTypes.FamilyName, "FamilyName"),
                        new Claim(JwtClaimTypes.WebSite, "WebSite"),
                        new Claim(JwtClaimTypes.Email, "Email"),
                        new Claim(JwtClaimTypes.EmailVerified, "EmailVerified", ClaimValueTypes.Boolean)
                    }
                },
                
            };
        }

        public UserModel ValidateCredentials(string username, string password)
        {
            // Logs in with the default user in the script
            // If you want to integrate an existing user management system (such as database), uses DatabaseUserStore instead
            var user = _users.FirstOrDefault(x => x.Username == username && x.Password == password);

            if (user != null)
            {
                // Logs the authentication-success information
                _logger.LogInformation($"User <{username}> logged in.");

                return user;
            }
            else
            {
                // Logs the authentication-failed information
                _logger.LogError($"Invalid login attempt.");

                return default;
            }
        }
    }
}