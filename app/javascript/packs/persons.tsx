import React from "react";

import { List, Datagrid, TextField, EmailField, DateField } from "react-admin";
import MyTextField from "./components/MyTextField";

export const PersonList = (props: any) => {
  return (
    <List {...props}>
      <Datagrid rowClick="edit">
        {/* <TextField source="id" /> */}
        <MyTextField source="id" />
        <EmailField source="firstName" />
        <EmailField source="lastName" />
        <DateField source="createdAt" />
      </Datagrid>
    </List>
  )
};