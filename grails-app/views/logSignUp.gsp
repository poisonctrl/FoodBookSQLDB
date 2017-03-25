<!doctype html>
<html>

<head>
    <title>Login / Sign-Up</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/react.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/0.13.3/JSXTransformer.js"></script>
</head>

<div id="pageContent"></div>
<div id="login"></div>
<div id="signup"></div>

<script type="text/jsx">



    var Title = React.createClass({

        render() {
            return(
                    <h1 id="title" className="title">Login / Sign-Up</h1>
            );
        }

    });

    React.render(<Title />, document.getElementById('pageContent'));


    var Login = React.createClass({

        getInitialState() {
            return {userFields: [],
                username : "",
                password : ""
            };
        },

        handleNameChange(e)
        {
            e.preventDefault();
            this.setState({ username : e.target.value  , success : "..."});
        },

        handlePassChange(e)
        {
            e.preventDefault();
            this.setState({ password : e.target.value  , success : "..."});

        },

        signIn(e) {
            e.preventDefault();
            var data = [username, password];
            console.log("Signing in...", this.form.data());
            fetch("localhost:8080/login/auth", {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(this.form.data())
            })
                .then(checkStatus)
                .then(this.success.bind(this))
                .catch(this.fail.bind(this))
        },

        render (){
            return (
                    <div className="loginContainer">
                        <form onSubmit={this.signIn}>
                            <label>
                                <div className="loginSign">Login:</div>
                                <div className="loginSign"><br/></div>
                                <div className="loginSign"><br/></div>
                                <div className="loginSign">Username:</div>
                                <input type="text" id="inbox2" defaultValue={this.state.password} onChange={this.handlePassChange}/>

                            </label>
                            <br/>
                            <label>
                                <div className="loginSign">Password:</div>
                                <input type="text" id="inbox2" defaultValue={this.state.password} onChange={this.handlePassChange}/>
                            </label>
                            <td/> <input type="submit" id="button" value="Login" />
                        </form>

                    </div>


            );
        }
    });
    React.render(<Login />, document.getElementById('login'));

    var Signup = React.createClass({

        getInitialState() {
            return {userFieldsSignUp: [],
                usernameNew : "",
                passwordNew : "",
                rePasswordNew: ""
            };
        },

        handleNameChangeNew(e)
        {
            e.preventDefault();
            this.setState({ usernameNew : e.target.value  , success : "..."});
        },

        handlePassChangeNew(e)
        {
            e.preventDefault();
            this.setState({ passwordNew : e.target.value  , success : "..."});
        },
        handleRePassChangeNew(e)
        {
            e.preventDefault();
            this.setState({ rePasswordNew : e.target.value  , success : "..."});
        },

        signUp(e) {
            e.preventDefault();
            var data = [usernameNew, passwordNew, rePasswordNew];
            console.log("Signing in...", this.form.data());
            fetch("localhost:8080/login/auth", {
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(this.form.data())
            })
                .then(checkStatus)
                .then(this.success.bind(this))
                .catch(this.fail.bind(this))
        },

        render (){
            return (
                    <div className="signUpContainer">
                        <form onSubmit={this.signUp}>
                            <label>
                                <div className="loginSign">Sign-Up:</div>
                                <div className="loginSign"><br/></div>
                                <div className="loginSign"><br/></div>
                                <div className="loginSign">Username:</div>
                                <input type="text"  defaultValue={this.state.usernameNew} onChange={this.handleNameChangeNew}/>

                            </label>
                            <label>
                                <div className="loginSign">Password:</div>
                                <input type="text"  defaultValue={this.state.passwordNew} onChange={this.handlePassChangeNew}/>

                            </label>
                            <label>
                                <div className="loginSign">Re-Enter Password:</div>
                                <input type="text"  defaultValue={this.state.rePasswordNew} onChange={this.handleRePassChangeNew}/>

                            </label>
                            <br/>
                            <td/> <input type="submit" id="button" value="Sign-Up" />
                        </form>

                    </div>

            );
        }
    });
    React.render(<Signup />, document.getElementById('signup'));
</script>
</html>
