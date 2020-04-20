import React from 'react';
import { Admin, Resource, ListGuesser, EditGuesser } from 'react-admin';
import jsonServerProvider from 'ra-data-json-server';
import { UserList } from "./users";
import { ClientList } from './clients';
import { PersonList, PersonEdit, PersonCreate } from './persons';
import PersonIcon from '@material-ui/icons/Person';
import BusinessIcon from '@material-ui/icons/Business';
import AccountCircleIcon from '@material-ui/icons/AccountCircle';
import Dashboard from "./Dashboard";

const dataProvider = jsonServerProvider('http://localhost:3000/api/v1');
const App = () => (
  <Admin dashboard={Dashboard} dataProvider={dataProvider}>
    <Resource name="users" list={UserList} icon={AccountCircleIcon} />
    <Resource name="clients" list={ClientList} icon={BusinessIcon} />
    <Resource name="persons" list={PersonList} edit={PersonEdit} create={PersonCreate} icon={PersonIcon} />
  </Admin>
);

export default App;